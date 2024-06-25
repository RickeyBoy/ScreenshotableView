//
//  ScreenshotableView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2023/7/19.
//

import SwiftUI

// MARK: - ScreenshotableViewStyle

public enum ScreenshotableViewStyle {
    /// 截图中的样式
    /// style in screenshot image
    case inScreenshot
    /// 正常展现的样式
    /// style in normally displayed View
    case inView
}

// MARK: - ScreenshotableScrollView

/// ScrollView supports screenshot
public struct ScreenshotableScrollView<Content: View>: View {
    @Binding var shotting: Bool
    var completed: (UIImage) -> Void
    let content: (_ style: ScreenshotableViewStyle) -> Content
    
    public init(shotting: Binding<Bool>, completed: @escaping (UIImage) -> Void, @ViewBuilder content: @escaping (_ style: ScreenshotableViewStyle) -> Content) {
        self._shotting = shotting
        self.completed = completed
        self.content = content
    }
    
    public var body: some View {
        ScreenshotableCotent(shotting: $shotting, completed: completed, content: content)
    }
}

// MARK: - ScreenshotableView

/// ScrollView supports screenshot
public struct ScreenshotableView<Content: View>: View {
    @Binding var shotting: Bool
    var completed: (UIImage) -> Void
    let content: (_ style: ScreenshotableViewStyle) -> Content
    
    public init(shotting: Binding<Bool>, completed: @escaping (UIImage) -> Void, @ViewBuilder content: @escaping (_ style: ScreenshotableViewStyle) -> Content) {
        self._shotting = shotting
        self.completed = completed
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            ScreenshotableCotent(shotting: $shotting, completed: completed, content: content)
        }
    }
}
