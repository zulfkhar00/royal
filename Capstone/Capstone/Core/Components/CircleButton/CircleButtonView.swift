//
//  CircleButtonView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 23.07.2023.
//

import SwiftUI

struct CircleButtonView: View {

    let iconName: String?
    let backgroundImageName: String?
    let width: CGFloat
    let height: CGFloat
    
    init(iconName: String? = nil, backgroundImageName: String? = nil, width: CGFloat = 50, height: CGFloat = 50) {
        self.iconName = iconName
        self.backgroundImageName = backgroundImageName
        self.width = width
        self.height = height
    }

    var body: some View {
        if let icon = iconName {
            Image(systemName: icon)
              .font(.headline)
              .foregroundColor(.theme.accent)
              .frame(width: width, height: height)
              .background(
                Circle().foregroundColor(.theme.background)
              )
              .shadow(
                color: .theme.accent.opacity(0.25),
                radius: 10, x: 0, y: 0
              )
              .padding()
        } else if let image = backgroundImageName {
            Image(image)
              .resizable()
              .clipShape(Circle())
              .font(.headline)
              .foregroundColor(.theme.accent)
              .frame(width: width, height: height)
              .background(
                Circle().foregroundColor(.theme.background)
              )
              .shadow(
                color: .theme.accent.opacity(0.25),
                radius: 10, x: 0, y: 0
              )
              .padding()
        } else {
            EmptyView()
        }
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        CircleButtonView(iconName: "info")
          .previewLayout(.sizeThatFits)

        CircleButtonView(backgroundImageName: "usd-flag")
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
    }
}
