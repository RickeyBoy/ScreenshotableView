//
//  ImagePreView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/6/28.
//

import SwiftUI

struct ImagePreView: View {
    let image: Image
    @Binding var isPresented: Bool // Binding variable to control visibility

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    isPresented = false // Dismiss the view
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
            }
            
            Spacer()
            
            Text("snapshot result:")
            image
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .background(Color.init(hex: "#EEEEEE"))
        .ignoresSafeArea()
    }
}

#Preview {
    ImagePreView(image: Image("ExampleImage"), isPresented: .constant(true))
}
