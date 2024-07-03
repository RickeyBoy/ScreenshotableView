//
//  NavigationButton.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/7/2.
//

import SwiftUI

struct NavigationButton: View {
    var destination: AnyView
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .padding()
                    Text(title)
                        .font(.headline)
                }
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing, .bottom])
            }
        }
    }
}
