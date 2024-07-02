//
//  CoreScreenshotExtensions.swift
//  
//
//  Created by Rickey on 2024/6/21.
//

import SwiftUI

extension UIView {
    func takeScreenshot(afterScreenUpdates: Bool) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}

extension View {
    func takeScreenshot(frame:CGRect, afterScreenUpdates: Bool) -> UIImage {
        let hosting = UIHostingController(rootView: self)
        hosting.overrideUserInterfaceStyle = UIApplication.shared.currentUIWindow()?.overrideUserInterfaceStyle ?? .unspecified
        hosting.view.frame = frame
        hosting.ignoreSafeArea()
        return hosting.view.takeScreenshot(afterScreenUpdates: afterScreenUpdates)
    }
}
