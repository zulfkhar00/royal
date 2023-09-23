//
//  DetailView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 08/09/2023.
//

import SwiftUI

struct DetailLoadingView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
                    .environmentObject(vm)
            }
        }
    }
    
}

struct DetailView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @StateObject private var detailVM: DetailViewModel
    @State private var showFullDescription = false
    @State private var isBuySheetPresented = false
    @State private var isSellSheetPresented = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    private var sellDisabled: Bool = true
    
    init(coin: CoinModel) {
        _detailVM = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    buyButton.padding(.trailing, 5)
                    sellButton
                    Spacer()
                }.padding()
                
                ChartView(coin: detailVM.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(detailVM.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
                .environmentObject(HomeViewModel())
        }
    }
}

extension DetailView {
    
    private var buyButton: some View {
        Button {
            isBuySheetPresented.toggle()
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Buy")
            }
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
                    .frame(width: 90, height: 45)
            )
        }
        .sheet(isPresented: $isBuySheetPresented) {
            BuyAndSellView(
                isBuyAndSellSheetPresented: $isBuySheetPresented,
                coin: detailVM.coin,
                operation: .buy
            )
            .environmentObject(vm)
        }
    }
    
    private var sellButton: some View {
        Button {
            isSellSheetPresented.toggle()
        } label: {
            HStack {
                Image(systemName: "minus")
                Text("Sell")
            }
            .foregroundColor(.blue.opacity(
                vm.coinExistsInPortfolio(coin: detailVM.coin) ?
                1 : 0.5
            ))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        Color.blue.opacity(
                            vm.coinExistsInPortfolio(coin: detailVM.coin) ?
                            0.2 : 0.06
                        )
                    )
                    .frame(width: 90, height: 45)
            )
        }
        .disabled(!vm.coinExistsInPortfolio(coin: detailVM.coin))
        .sheet(isPresented: $isSellSheetPresented) {
            BuyAndSellView(
                isBuyAndSellSheetPresented: $isSellSheetPresented,
                coin: detailVM.coin,
                operation: .sell
            )
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = detailVM.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }.accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(detailVM.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(detailVM.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var navigationTrailingItems: some View {
        HStack {
            Text(detailVM.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: detailVM.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteStr = detailVM.websiteURL,
               let url = URL(string: websiteStr) {
                Link("Website", destination: url)
            }
            
            if let redditStr = detailVM.redditURL,
               let url = URL(string: redditStr) {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
}
