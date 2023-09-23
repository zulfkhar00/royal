//
//  BuyAndSellViewModel.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 16/09/2023.
//

import Foundation

enum TransactionStatus: String {
    case successful = "Successful"
    case notEnoughMoney = "Not enough money"
    case notEnoughCoins = "Not enough coins"
    case failed = "Something went wrong"
}

enum TransactionMethod {
    case curreny, coin
}

class BuyAndSellViewModel {
    
    func buy(
        coin: CoinModel,
        with paymentMethod: TransactionMethod,
        amount: Double,
        vm: HomeViewModel
    ) -> TransactionStatus {
        switch paymentMethod {
        case .coin:
            guard walletMoneyIsSufficientToBuy(coin: coin, amount: amount, vm: vm) else {
                return .notEnoughMoney
            }
            vm.addCoinToPortfolio(coin: coin, amount: amount)
            vm.payFromWallet(amount: coin.currentPrice * amount)
        case .curreny:
            guard walletMoneyIsSufficientThan(amount: amount, vm: vm) else {
                return .notEnoughMoney
            }
            vm.addCoinToPortfolio(coin: coin, amount: amount/coin.currentPrice)
            vm.payFromWallet(amount: amount)
        }
        return .successful
    }
    
    func sell(
        coin: CoinModel,
        with paymentMethod: TransactionMethod,
        amount: Double,
        vm: HomeViewModel
    ) -> TransactionStatus {
        switch paymentMethod {
        case .coin:
            guard vm.portfolioHasSufficient(amount: amount, of: coin) else {
                return .notEnoughCoins
            }
            vm.sellCoinFromPortfolio(coin: coin, amount: amount)
            vm.addMoneyToWallet(amount: coin.currentPrice * amount)
        case .curreny:
            guard vm.portfolioHasSufficient(amount: amount/coin.currentPrice, of: coin) else {
                return .notEnoughCoins
            }
            vm.sellCoinFromPortfolio(coin: coin, amount: amount/coin.currentPrice)
            vm.addMoneyToWallet(amount: amount)
        }
        return .successful
    }
    
    func walletMoneyIsSufficientToBuy(coin: CoinModel, amount: Double, vm: HomeViewModel) -> Bool {
        return vm.walletBalance >= coin.currentPrice * amount
    }
    
    func walletMoneyIsSufficientThan(amount: Double, vm: HomeViewModel) -> Bool {
        return vm.walletBalance >= amount
    }
    
}
