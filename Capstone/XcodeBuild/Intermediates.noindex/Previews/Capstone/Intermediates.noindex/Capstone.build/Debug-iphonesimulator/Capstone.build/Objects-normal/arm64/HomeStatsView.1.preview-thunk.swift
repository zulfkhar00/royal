@_private(sourceFile: "HomeStatsView.swift") import Capstone
import SwiftUI
import SwiftUI

extension HomeStatsView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeStatsView.swift", line: 28)
      HomeStatsView(showPortfolio: .constant(__designTimeBoolean("#1728.[2].[0].property.[0].[0].arg[0].value.arg[0].value", fallback: false)))
        .environmentObject(dev.homeVM)
    
#sourceLocation()
    }
}

extension HomeStatsView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeStatsView.swift", line: 16)
      HStack {
        ForEach(vm.statistics) { stat in
          StatisticView(stat: stat)
            .frame(width: UIScreen.main.bounds.width / __designTimeInteger("#1728.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.[0]", fallback: 3))
        }
      }
      .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .leading : .trailing)
    
#sourceLocation()
    }
}

import struct Capstone.HomeStatsView
import struct Capstone.HomeStatsView_Previews

