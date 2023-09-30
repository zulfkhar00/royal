//
//  User.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 15/09/2023.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let isArtist: Bool
    var wallet: Wallet
    var portfolio: Portfolio
    var publishedCoins: [PublishedCoin]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case isArtist = "is_artist"
        case wallet
        case portfolio
        case publishedCoins = "published_coins"
    }
}

struct PublishedCoin: Codable {
    let coinID: String
    
    enum CodingKeys: String, CodingKey {
        case coinID = "coin_id"
    }
}

struct Wallet: Codable {
    var balance: Double
}

struct Portfolio: Codable {
    var stocks: [MusicStock]
}

struct MusicStock: Codable {
    let id: String
    var amount: Double
}
