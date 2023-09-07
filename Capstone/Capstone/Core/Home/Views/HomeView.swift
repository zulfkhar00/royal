//
//  HomeView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 23.07.2023.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio = false // animate right
    @State private var showPortfolioView = false // new sheet

    var body: some View {
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

          Spacer(minLength: 0)
        }
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        HomeView().navigationBarHidden(true)
      }
      .environmentObject(dev.homeVM)
    }
}

extension HomeView {

  private var headerView: some View {
    HStack {
      CircleButtonView(iconName: showPortfolio ? "plus" : "info")
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

      Text(showPortfolio ? "Portfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(.theme.accent)
        .withoutAnimation()

      Spacer()

      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()) {
            showPortfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }

  private var allCoinsList: some View {
    List {
      ForEach(vm.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }

  private var portfolioCoinsList: some View {
    List {
      ForEach(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
      }
    }
    .listStyle(PlainListStyle())
  }

  private var columnTitles: some View {
    HStack {
      Text("Coin")
      Spacer()
      if showPortfolio {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
    }
    .font(.caption)
    .foregroundColor(.theme.secondaryText)
    .padding(.horizontal)
  }

}
