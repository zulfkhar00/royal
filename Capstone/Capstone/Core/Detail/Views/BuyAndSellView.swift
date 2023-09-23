//
//  BuyAndSellView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 16/09/2023.
//

import SwiftUI

enum BuyAndSellOperartion {
    case buy, sell
}

enum ActiveTextField {
    case stockField, moneyField
}

struct BuyAndSellView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @Binding var isBuyAndSellSheetPresented: Bool
    private let buyAndSellViewModel = BuyAndSellViewModel()
    let coin: CoinModel
    let operation: BuyAndSellOperartion
    @State private var stockAmount: String = ""
    @State private var moneyAmount: String = ""
    @State private var showingAlert = false
    @State private var transactionStatus: TransactionStatus? = nil
    @State private var activeTextField: ActiveTextField? = nil
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                            stockAmountInput
                            moneyAmountInput
                            Spacer()
                            buyAndSellButton
                    }
                    .withoutAnimation()
                    .padding()
                    .font(.headline)
                    .frame(height: geometry.size.height)
                }
                .background(Color.theme.background.ignoresSafeArea())
                .navigationTitle(operation == .buy ? "Buy \(coin.name)" : "Sell \(coin.name)")
            }
        }
    }
}

struct BuyAndSellView_Previews: PreviewProvider {
    static var previews: some View {
        BuyAndSellView(
            isBuyAndSellSheetPresented: .constant(true),
            coin: dev.coin,
            operation: .buy
        )
        .environmentObject(dev.homeVM)
    }
}

extension BuyAndSellView {
    private var stockAmountInput: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(coin.symbol.uppercased())
                Text("Owned: \(vm.amountOfCoinInPortfolio(coin: coin))")
                    .font(.subheadline)
            }
            .padding()
            Spacer()
            TextField("+0", text: $stockAmount)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled()
                .padding()
                .multilineTextAlignment(.trailing)
                .onTapGesture {
                    activeTextField = .stockField
                    moneyAmount = "0.0"
                }
        }
        .background(
            RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.1))
        )
    }
    
    private var moneyAmountInput: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("USD")
                Text("Balance: $\(vm.walletBalance.asNumberString())")
                    .font(.subheadline)
            }
            .padding()
            Spacer()
            TextField("-$0", text: $moneyAmount)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled()
                .padding()
                .multilineTextAlignment(.trailing)
                .onTapGesture {
                    activeTextField = .moneyField
                    stockAmount = "0.0"
                }
        }
        .background(
            RoundedRectangle(cornerRadius: 15).fill(Color.gray.opacity(0.1))
        )
    }
    
    private var buyAndSellButton: some View {
        Button {
            triggerTransaction()
        } label: {
            Text(operation == .buy ? "Buy" : "Sell")
                .frame(width: 360, height: 50)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 15).fill(Color.blue)
                )
        }
        .alert(transactionStatus?.rawValue ?? "", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                if let status = transactionStatus, status == .successful {
                    isBuyAndSellSheetPresented.toggle()
                }
            }
        }
    }
    
    private func triggerTransaction() {
        guard activeTextField != nil else { return }
        if operation == .buy {
            transactionStatus = buyAndSellViewModel.buy(
                coin: coin,
                with: activeTextField == .stockField ? .coin : .curreny,
                amount: Double(activeTextField == .stockField ? stockAmount : moneyAmount)!,
                vm: vm
            )
        } else {
            transactionStatus = buyAndSellViewModel.sell(
                coin: coin,
                with: activeTextField == .stockField ? .coin : .curreny,
                amount: Double(activeTextField == .stockField ? stockAmount : moneyAmount)!,
                vm: vm
            )
        }
        showingAlert.toggle()
    }
    
}
