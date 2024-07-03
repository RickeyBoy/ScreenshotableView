//
//  ScrollScreenshotView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/6/19.
//

import SwiftUI
import ScreenshotableView

/// 生成随机颜色
/// generate random color
extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

struct ScrollScreenshotView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil
    @State var showResult = false
    
    let colors = generateRandomColors()
    
    var body: some View {
        VStack {
            Text("Scrollview ↓")
            ScreenshotableContent()
            
            Button("Generate Screenshot") {
                shotting.toggle()
                showResult.toggle()
            }
            .padding()
        }
        .sheet(isPresented: $showResult) {
            if let screenshot {
                ImagePreView(image: screenshot, isPresented: $showResult)
            }
        }
    }
    
    private func ScreenshotableContent() -> some View {
        ScreenshotableScrollView(shotting: $shotting) { screenshot in
            self.screenshot = Image(uiImage: screenshot)
        } content: { style in
            VStack {
                ForEach(0..<colors.count, id: \.self) { index in
                    Rectangle()
                        .fill(colors[index])
                        .frame(height: 100)
                        .padding(2)
                }
            }
            .padding()
            .border(.black)
            .padding()
        }
    }
    
    static func generateRandomColors(count: Int = 10) -> [Color] {
        return (0..<count).map { _ in Color.random }
    }
}

#Preview {
    ScrollScreenshotView()
}
