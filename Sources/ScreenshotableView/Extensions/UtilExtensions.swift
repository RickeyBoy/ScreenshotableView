//
//  UtilExtensions.swift
//
//  Created by Rickey on 2023/7/19.
//

import SwiftUI

extension UIHostingController {
    func ignoreSafeArea() {
        if #available(iOS 16.4, *) {
            self.safeAreaRegions = []
        } else {
            let currentSafeAreaInset = UIApplication.shared.currentUIWindow()?.safeAreaInsets ?? .zero
            self.additionalSafeAreaInsets = currentSafeAreaInset.reversed()
        }
    }
}

extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}

extension UIEdgeInsets {
    func reversed() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}

