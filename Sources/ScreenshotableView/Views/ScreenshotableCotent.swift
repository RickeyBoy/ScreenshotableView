//
//  SwiftUIView.swift
//  
//
//  Created by Rickey on 2024/6/21.
//

import SwiftUI

/// Normal View supports screenshot
struct ScreenshotableCotent<Content: View>: View {
    @Binding var shotting: Bool
    var completed: (UIImage) -> Void
    let content: (_ style: ScreenshotableViewStyle) -> Content
    
    public var body: some View {
        func internalView(proxy: GeometryProxy) -> some View {
            if self.shotting {
                let frame = proxy.frame(in: .local)
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
