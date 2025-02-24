//
//  UIViewRepresentableScreenshotView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/8/21.
//

import SwiftUI
import ScreenshotableView

struct TextView: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
}

struct UIViewRepresentableScreenshotView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil
    @State var showResult = false
    
    @State var text = NSMutableAttributedString(string: "UIViewRepresentable")

    var body: some View {
        VStack(spacing: 40) {
            ScreenshotableView(shotting: $shotting) { screenshot in
                self.screenshot = Image(uiImage: screenshot)
            } content: { style in
                TextView(text: $text)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            
            Button("Generate Screenshot") {
                shotting.toggle()
                showResult.toggle()
            }
        }
        .sheet(isPresented: $showResult) {
            if let screenshot {
                ImagePreView(image: screenshot, isPresented: $showResult)
            }
        }
    }
}

#Preview {
    UIViewRepresentableScreenshotView()
}
