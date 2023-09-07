@_private(sourceFile: "HomeView.swift") import Capstone
import SwiftUI
import SwiftUI

extension HomeView {
    @_dynamicReplacement(for: columnTitles) private var __preview__columnTitles: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeView.swift", line: 111)
    HStack {
      Text(__designTimeString("#1856.[3].[3].property.[0].[0].arg[0].value.[0].arg[0].value", fallback: "Coin"))
      Spacer()
      if showPortfolio {
        Text(__designTimeString("#1856.[3].[3].property.[0].[0].arg[0].value.[2].[0].[0].arg[0].value", fallback: "Holdings"))
      }
      Text(__designTimeString("#1856.[3].[3].property.[0].[0].arg[0].value.[3].arg[0].value", fallback: "Price"))
        .frame(width: UIScreen.main.bounds.width/__designTimeFloat("#1856.[3].[3].property.[0].[0].arg[0].value.[3].modifier[0].arg[0].value.[0]", fallback: 3.5), alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
    .padding(.horizontal)
  
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: portfolioCoinsList) private var __preview__portfolioCoinsList: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeView.swift", line: 101)
    List {
      ForEach(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: __designTimeBoolean("#1856.[3].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].arg[1].value", fallback: true))
          .listRowInsets(.init(top: __designTimeInteger("#1856.[3].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[0].value", fallback: 10), leading: __designTimeInteger("#1856.[3].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[1].value", fallback: 0), bottom: __designTimeInteger("#1856.[3].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[2].value", fallback: 10), trailing: __designTimeInteger("#1856.[3].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[3].value", fallback: 0)))
      }
    }
    .listStyle(PlainListStyle())
  
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: allCoinsList) private var __preview__allCoinsList: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeView.swift", line: 91)
    List {
      ForEach(vm.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: __designTimeBoolean("#1856.[3].[1].property.[0].[0].arg[0].value.[0].arg[1].value.[0].arg[1].value", fallback: false))
          .listRowInsets(.init(top: __designTimeInteger("#1856.[3].[1].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[0].value", fallback: 10), leading: __designTimeInteger("#1856.[3].[1].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[1].value", fallback: 0), bottom: __designTimeInteger("#1856.[3].[1].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[2].value", fallback: 10), trailing: __designTimeInteger("#1856.[3].[1].property.[0].[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value.arg[3].value", fallback: 10)))
      }
    }
    .listStyle(PlainListStyle())
  
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: headerView) private var __preview__headerView: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeView.swift", line: 57)
    HStack {
      CircleButtonView(iconName: showPortfolio ? __designTimeString("#1856.[3].[0].property.[0].[0].arg[0].value.[0].arg[0].value.then", fallback: "plus") : __designTimeString("#1856.[3].[0].property.[0].[0].arg[0].value.[0].arg[0].value.else", fallback: "info"))
        .withoutAnimation()
        .onTapGesture {
          if showPortfolio {
            showPortfolioView.toggle()
          }
        }
        .background(
          CircleButtonAnimationView(animate: $showPortfolio)
        )

      Spacer()

      Text(showPortfolio ? __designTimeString("#1856.[3].[0].property.[0].[0].arg[0].value.[2].arg[0].value.then", fallback: "Portfolio") : __designTimeString("#1856.[3].[0].property.[0].[0].arg[0].value.[2].arg[0].value.else", fallback: "Live Prices"))
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(.theme.accent)
        .withoutAnimation()

      Spacer()

      CircleButtonView(iconName: __designTimeString("#1856.[3].[0].property.[0].[0].arg[0].value.[4].arg[0].value", fallback: "chevron.right"))
        .rotationEffect(Angle(degrees: showPortfolio ? __designTimeInteger("#1856.[3].[0].property.[0].[0].arg[0].value.[4].modifier[0].arg[0].value.arg[0].value.then", fallback: 180) : __designTimeInteger("#1856.[3].[0].property.[0].[0].arg[0].value.[4].modifier[0].arg[0].value.arg[0].value.else", fallback: 0)))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  
#sourceLocation()
    }
}

extension HomeView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeView.swift", line: 47)
      NavigationView {
        HomeView().navigationBarHidden(__designTimeBoolean("#1856.[2].[0].property.[0].[0].arg[0].value.[0].modifier[0].arg[0].value", fallback: true))
      }
      .environmentObject(dev.homeVM)
    
#sourceLocation()
    }
}

extension HomeView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/zulfkhar/Desktop/capstone_project/Capstone/Capstone/Core/Home/Views/HomeView.swift", line: 17)
      ZStack {
        Color.theme.background
          .ignoresSafeArea()
          .sheet(isPresented: $showPortfolioView) {
            PortfolioView()
              .environmentObject(vm)
          }
        VStack {
          headerView
          HomeStatsView(showPortfolio: $showPortfolio)
          SearchBarView(searchText: $vm.searchText)
          columnTitles
          
          if !showPortfolio {
            allCoinsList
              .transition(.move(edge: .leading))
          }
          if showPortfolio {
            portfolioCoinsList
              .transition(.move(edge: .trailing))
          }

          Spacer(minLength: __designTimeInteger("#1856.[1].[3].property.[0].[0].arg[0].value.[1].arg[0].value.[6].arg[0].value", fallback: 0))
        }
      }
    
#sourceLocation()
    }
}

import struct Capstone.HomeView
import struct Capstone.HomeView_Previews

