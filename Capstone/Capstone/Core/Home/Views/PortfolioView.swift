//
//  PortfolioView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 08.08.2023.
//

import SwiftUI

struct PortfolioView: View {

    var body: some View {
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            Text("hi")
          }
        }
        .navigationTitle("Edit Portfolio")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            XMarkButton()
          }
        }
      }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
