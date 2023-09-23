//
//  WalletDataService.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 17/09/2023.
//

import SwiftUI

class WalletDataService {

    private var user: User?
    
    init() {}
    
    func set(user: User?) {
        guard let user = user else { return }
        self.user = user
    }
    
    func syncWalletBalance(balance: Double, receiveUpdatedUserInfo: @escaping (User) -> ()) {
        guard let user = user else { return }
        let endpoint = "http://localhost:4000/sync_wallet_balance"
        guard let url = URL(string: endpoint) else { return }
        
        let requestBody: [String : AnyHashable] = [
            "user_id": user.id,
            "balance": balance
        ]
        
        NetworkingManager.post(url: url, requestBody: requestBody) { data in
            do {
                let updatedUsedInfo = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    receiveUpdatedUserInfo(updatedUsedInfo)
                }
            } catch let error {
                print("Error decoding User info when syncPortfolioCoin(coin: CoinModel, amount: Double): \(error.localizedDescription)")
            }
        }
    }
    
    func syncPortfolioCoin(coin: CoinModel, amount: Double, receiveUpdatedUserInfo: @escaping (User) -> ()) {
        guard let user = user else { return }
        let endpoint = "http://localhost:4000/sync_coin"
        guard let url = URL(string: endpoint) else { return }
        
        let requestBody: [String : AnyHashable] = [
            "user_id": user.id,
            "music_coin_id": coin.id,
            "amount": amount
        ]
        
        NetworkingManager.post(url: url, requestBody: requestBody) { data in
            do {
                let updatedUsedInfo = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    receiveUpdatedUserInfo(updatedUsedInfo)
                }
            } catch let error {
                print("Error decoding User info when syncPortfolioCoin(coin: CoinModel, amount: Double): \(error.localizedDescription)")
            }
        }
    }
    
    
}
