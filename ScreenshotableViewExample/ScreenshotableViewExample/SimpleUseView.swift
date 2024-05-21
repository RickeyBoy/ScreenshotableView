//
//  SimpleUseView.swift
//  ScreenshotableViewExample
//
//  Created by Wang Timo on 2024/5/21.
//

import SwiftUI
import ScreenshotableView

struct SimpleUseView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil
    
    @State var forgroundColorOfScreenShot: Color = .black
    @State var backgroundColorOfScreenShot: Color = .green
    @State var radiusOfScreenShot: CGFloat = 10
    
    var body: some View {
        VStack(spacing: 40) {
            ScreenshotableView(shotting: $shotting) { screenshot in
                self.screenshot = Image(uiImage: screenshot)
            } content: { style in
                Content(style: style)
            }
            
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
            
            Button("Generate Screenshot") {
                shotting.toggle()
            }
            
            if let screenshot {
                VStack(spacing: 20) {
                    Text("snapshot result:")
                    screenshot
                        .frame(height: 60)
                }
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
    SimpleUseView()
}
