//
//  ImageShotView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/6/28.
//

import SwiftUI
import ScreenshotableView

struct ImageShotView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil
    @State var showResult = false
    
    private let hexs = ["#3D7839", "#719044", "#9AA552", "#D9CD2F", "#BA947F"]
        
    var body: some View {
        VStack {
            ScreenshotableView(shotting: $shotting) { screenshot in
                self.screenshot = Image(uiImage: screenshot)
            } content: { style in
                VStack(spacing: 4) {
                    MainImage()
                    // PLEASE use .opacity
                    ExtraInfo().opacity(style == .inScreenshot ? 1 : 0)
                }
                .padding(22)
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
    
    private func MainImage() -> some View {
        VStack(spacing: 4) {
            Image("ExampleImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack(spacing: 3) {
                ForEach(hexs, id: \.self) { hex in
                    ZStack(alignment: .bottomTrailing) {
                        Rectangle()
                            .foregroundColor(Color.init(hex: hex))
                        Text(hex)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .padding(2)
                            .padding(4)
                    }
                    .frame(minHeight: 150, maxHeight: 200)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
    
    private func ExtraInfo() -> some View {
        HStack {
            Image("QRCode")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    Image("AppIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 24)
                    Image("Brand")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 24)
                }
                .padding(.bottom, 4)
                
                Text("Download iColors in App Store!")
                    .font(.system(size: 14))
            }
        }
        .padding(.top)
    }
}

#Preview {
    ImageShotView()
}
