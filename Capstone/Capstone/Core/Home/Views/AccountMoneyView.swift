//
//  AccountMoneyView.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 15/09/2023.
//

import SwiftUI

struct AccountMoneyView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack(alignment: .center, spacing: 0) {
                    HStack {
                        Text("\(vm.walletBalance.asCurrencyWith2Decimals())")
                            .font(.largeTitle)
                        accountChooser
                        Spacer()
                        CircleButtonView(backgroundImageName: "usd-flag")
                    }
                    
                    HStack {
                        addMoney
                        exchangeMoney
                        info
                    }
                }
            }
        }
    }
}

struct AccountMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        AccountMoneyView()
            .environmentObject(dev.homeVM)
    }
}

extension AccountMoneyView {
    
    var accountChooser: some View {
        Button(action: {
            print()
        }, label: {
            Image(systemName: "arrow.down.circle.fill")
                .font(.headline)
        })
    }
    
    var addMoney: some View {
        VStack {
            CircleButtonView(iconName: "plus", width: 40, height: 40)
                .frame(width: 40, height: 40)
                .onTapGesture {
                    vm.addMoneyToWallet(amount: 100)
                }
            Text("Add money")
                .font(.subheadline)
        }
        .frame(width: 95)
    }
    
    var exchangeMoney: some View {
        VStack {
            CircleButtonView(iconName: "repeat", width: 40, height: 40)
                .frame(width: 40, height: 40)
            Text("Exchange")
                .font(.subheadline)
        }
        .frame(width: 95)
    }
    
    var info: some View {
        VStack {
            CircleButtonView(iconName: "info", width: 40, height: 40)
                .frame(width: 40, height: 40)
            Text("More")
                .font(.subheadline)
        }
        .frame(width: 95)
    }
    
}
