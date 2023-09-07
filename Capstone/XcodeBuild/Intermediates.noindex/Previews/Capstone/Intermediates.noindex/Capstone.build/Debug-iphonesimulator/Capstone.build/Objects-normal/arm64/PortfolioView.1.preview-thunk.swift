@_private(sourceFile: "PortfolioView.swift") import Capstone
import SwiftUI
import SwiftUI

extension PortfolioView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/PortfolioView.swift", line: 31)
        PortfolioView()
    
#sourceLocation()
    }
}

extension PortfolioView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/PortfolioView.swift", line: 13)
      NavigationView {
        ScrollView {
          VStack(alignment: .leading, spacing: __designTimeInteger("#4646.[1].[0].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value", fallback: 0)) {
            Text(__designTimeString("#4646.[1].[0].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[2].value.[0].arg[0].value", fallback: "hi"))
          }
        }
        .navigationTitle(__designTimeString("#4646.[1].[0].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value", fallback: "Edit Portfolio"))
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            XMarkButton()
          }
        }
      }
    
#sourceLocation()
    }
}

import struct Capstone.PortfolioView
import struct Capstone.PortfolioView_Previews

