//
//  ScrollScreenshotView.swift
//  ScreenshotableViewExample
//
//  Created by Wang Timo on 2024/6/19.
//

import ScreenshotableView
import SwiftUI

/// 生成随机颜色
/// generate random color
extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

// MARK: - ScrollScreenshotView

struct ScrollScreenshotView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil

    let colors = generateRandomColors()

    var body: some View {
        VStack(spacing: 40) {
            if let screenshot {
                Text("Screenshot result ↓")
                screenshot
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 400)
            } else {
                Text("Scrollview ↓")
                ScrollView {
                    ScreenshotableContent()
                }
                .frame(height: 400)
            }

            Button("Generate Screenshot") {
                shotting.toggle()
            }
            Button("Clear Screenshot") {
                screenshot = nil
            }
        }
    }

    private func ScreenshotableContent() -> some View {
        ScreenshotableScrollView(shotting: $shotting) { screenshot in
            self.screenshot = Image(uiImage: screenshot)
        } content: { _ in
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
