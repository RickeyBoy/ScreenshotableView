//
//  ScreenshotableView.swift
//  ScreenshotableViewExample
//
//  Created by Wang Timo on 2023/7/19.
//

import SwiftUI
import UIKit

// 需要注意，inView 和 inSnapshot 的 frame 要一样
public enum ScreenshotableViewStyle {
    case inSnapshot /// 截图中的样式
    case inView /// 展现在 View 中的样式
}

public struct ScreenshotableView<Content: View>: View {
    @Binding var shotting: Bool
    var completed: (UIImage) -> Void
    let content: (_ style: ScreenshotableViewStyle) -> Content
    
    public init(shotting:Binding<Bool>, completed: @escaping (UIImage) -> Void, @ViewBuilder content: @escaping (_ style: ScreenshotableViewStyle) -> Content) {
        self._shotting = shotting
        self.completed = completed
        self.content = content
    }
    
    public var body: some View {
        
        func internalView(proxy: GeometryProxy) -> some View {
            if self.shotting {
                let frame = proxy.frame(in: .global)
                DispatchQueue.main.async {
                    shotting = false
                    // 截图时用 inSnapshot 的样式
                    let screenshot = self.content(.inSnapshot).takeScreenshot(frame: frame, afterScreenUpdates: true)
                    self.completed(screenshot)
                }
            }
            return Color.clear
        }
        
        // 展示 inView 的样式
        return content(.inView).background(GeometryReader(content: internalView(proxy:)))
    }
}
