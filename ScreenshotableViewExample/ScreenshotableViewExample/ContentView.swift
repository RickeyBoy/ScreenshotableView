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
            VStack() {
                Spacer()
                NavigationLink(destination: SimpleUseView()) {
                    VStack {
                        Image(systemName: "lightbulb")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .padding()
                        Text("Simple Use")
                            .font(.headline)
                    }
                }
                Spacer()
                NavigationLink(destination: ShareScreenshotView()) {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .padding()
                        Text("Share Screenshot")
                            .font(.headline)
                    }
                }
                Spacer()
                NavigationLink(destination: ScrollScreenshotView()) {
                    VStack {
                        Image(systemName: "scroll")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .padding()
                        Text("Screenshot For ScrollView")
                            .font(.headline)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Screenshot!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
