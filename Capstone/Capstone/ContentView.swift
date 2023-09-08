//
//  ContentView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 40) {
                Text("Accent color").foregroundColor(.theme.accent)
                Text("Secondary text color").foregroundColor(.theme.secondaryText)
                Text("Red color").foregroundColor(.theme.red)
                Text("Green color").foregroundColor(.theme.green)
            }.font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
