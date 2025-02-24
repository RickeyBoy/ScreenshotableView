//
//  ContentView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2023/7/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                NavigationButton(
                    destination: AnyView(UIViewRepresentableScreenshotView()),
                    imageName: "pencil.and.outline",
                    title: "Basic use",
                    description: "Basic use of the component with customization."
                )
                
                NavigationButton(
                    destination: AnyView(ImageShotView()),
                    imageName: "photo.on.rectangle",
                    title: "Image with QR code",
                    description: "Capture an image and merge QR codes and logos."
                )
                
                NavigationButton(
                    destination: AnyView(ScrollScreenshotView()),
                    imageName: "scroll",
                    title: "Use with ScrollView",
                    description: "Capture full content of a scroll view."
                )
                
                NavigationButton(
                    destination: AnyView(ShareScreenshotView()),
                    imageName: "square.and.arrow.up",
                    title: "Screenshot then share",
                    description: "Integrate screenshot with share button."
                )
            }
            .padding()
            .padding(.bottom)
            .navigationBarTitle("Screenshot!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
