//
//  ShareScreenshotView.swift
//  ScreenshotableViewExample
//
//  Created by Wang Timo on 2024/5/21.
//

import SwiftUI
import ScreenshotableView

struct ShareScreenshotView: View {
    @State var forgroundColorOfScreenShot: Color = .black
    @State var backgroundColorOfScreenShot: Color = .green
    @State var radiusOfScreenShot: CGFloat = 10
    
    @StateObject var sasVM = SaveAndShareViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            ScreenshotableView(shotting: $sasVM.shotting) { screenshot in
                sasVM.sharedImage = screenshot
            } content: { style in
                Content(style: style)
            }
            .supportSaveAndShare(sasVM: sasVM)
            
            VStack {
                Text("Configs of screenshot")
                ColorPicker("forgroundColor:", selection: $forgroundColorOfScreenShot)
                ColorPicker("backgroundColor:", selection: $backgroundColorOfScreenShot)
                HStack {
                    Text("radius: \(Int(radiusOfScreenShot))")
                    Slider(value: $radiusOfScreenShot, in: 0...20, step: 1)
                }
            }
            .padding([.leading, .trailing], 50)
            
            Button("Share Screenshot") {
                sasVM.share()
            }
            
        }
    }
    
    @ViewBuilder
    func Content(style: ScreenshotableViewStyle) -> some View {
        HStack {
            Image(systemName: "iphone.gen2")
                .imageScale(.large)
            Text("ScreenshotableView")
                .font(.title)
        }
        .frame(height: 60)
        .foregroundColor(style == .inView ? .white : forgroundColorOfScreenShot)
        .padding()
        .background(style == .inView ? .blue : backgroundColorOfScreenShot)
        .cornerRadius(style == .inView ? 4 : radiusOfScreenShot)
    }
}

#Preview {
    ShareScreenshotView()
}
