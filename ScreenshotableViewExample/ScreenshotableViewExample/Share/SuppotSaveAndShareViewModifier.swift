//
//  SuppotSaveAndShareViewModifier.swift
//  ScreenshotableViewExample
//
//  Created by Wang Timo on 2024/5/21.
//

import SwiftUI

struct SuppotSaveAndShareViewModifier: ViewModifier {
    @StateObject var sasVM: SaveAndShareViewModel
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $sasVM.showShareSheet, content: {
                ShareSheetView(activityItems: $sasVM.shareItems) { activityType, completed, returnedItems, error in
                    if completed {
                        // do something
                    }
                }
            })
            .onChange(of: sasVM.sharedImage) { newValue in
                if let image = newValue {
                    // share
                    if sasVM.sharing {
                        sasVM.shareItems = [image]
                        sasVM.showShareSheet.toggle()
                        sasVM.sharing = false
                    }
                }
            }
    }
}

extension View {
    /// 支持保存图片 & 分享
    func supportSaveAndShare(sasVM: SaveAndShareViewModel) -> some View {
        modifier(SuppotSaveAndShareViewModifier(sasVM: sasVM))
    }
}

/// 支持保存图片 & 分享
final class SaveAndShareViewModel : ObservableObject {
    @Published var sharedImage: UIImage? = nil
    @Published var shotting = false
    
    @Published fileprivate var sharing = false
    
    @Published fileprivate var showShareSheet = false
    @Published fileprivate var shareItems: [Any] = []
    
    func share() {
        shotting = true
        sharing = true
    }
}
