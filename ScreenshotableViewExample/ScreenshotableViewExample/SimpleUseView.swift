//
//  SimpleUseView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/5/21.
//

import SwiftUI
import ScreenshotableView

struct SimpleUseView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil
    @State var showResult = false
    
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
                showResult.toggle()
            }
        }
        .sheet(isPresented: $showResult) {
            if let screenshot {
                ImagePreView(image: screenshot, isPresented: $showResult)
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
