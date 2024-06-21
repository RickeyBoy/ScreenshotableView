//
//  ScreenshotableView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2023/7/19.
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

/// ScrollView supports screenshot
public struct ScreenshotableScrollView<Content: View>: View {
    @Binding var shotting: Bool
    var completed: (UIImage) -> Void
    let content: (_ style: ScreenshotableViewStyle) -> Content
    
    public init(shotting:Binding<Bool>, completed: @escaping (UIImage) -> Void, @ViewBuilder content: @escaping (_ style: ScreenshotableViewStyle) -> Content) {
        self._shotting = shotting
        self.completed = completed
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            ScreenshotableCotent(shotting: $shotting, completed: completed, content: content, isinScrollView: true)
        }
    }
}

/// ScrollView supports screenshot
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
        ZStack {
            ScreenshotableCotent(shotting: $shotting, completed: completed, content: content, isinScrollView: true)
        }
    }
}

/// Normal View supports screenshot
public struct ScreenshotableCotent<Content: View>: View {
    @Binding public var shotting: Bool
    var completed: (UIImage) -> Void
    let content: (_ style: ScreenshotableViewStyle) -> Content
    var isInScrollView: Bool = false
    
    public init(shotting:Binding<Bool>, completed: @escaping (UIImage) -> Void, @ViewBuilder content: @escaping (_ style: ScreenshotableViewStyle) -> Content) {
        self._shotting = shotting
        self.completed = completed
        self.content = content
    }
    
    init(shotting:Binding<Bool>, completed: @escaping (UIImage) -> Void, @ViewBuilder content: @escaping (_ style: ScreenshotableViewStyle) -> Content, isinScrollView: Bool) {
        self.init(shotting: shotting, completed: completed, content: content)
        self.isInScrollView = isinScrollView
    }
    
    public var body: some View {
        func internalView(proxy: GeometryProxy) -> some View {
            if self.shotting {
                let frame = proxy.frame(in: isInScrollView ? .local : .global)
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
