//
//  ScreenshotableView.swift
//  ScreenshotableViewExample
//
//  Created by Wang Timo on 2023/7/19.
//

import SwiftUI
import UIKit

public enum ScreenshotableViewStyle {
    /// 截图中的样式
    /// style in screenshot image
    case inScreenshot
    /// 正常展现的样式
    /// style in normally displayed View
    case inView
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
                    // Use content with '.inScreenshot' style while taking a screenshot
                    let screenshot = self.content(.inScreenshot).takeScreenshot(frame: frame, afterScreenUpdates: true)
                    self.completed(screenshot)
                }
            }
            return Color.clear
        }
        
        // 展示 inView style 的内容
        // Display content with 'inView' style
        return content(.inView).background(GeometryReader(content: internalView(proxy:)))
    }
}
