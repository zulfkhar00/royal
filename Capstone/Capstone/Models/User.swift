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
    var wallet: Wallet
    var portfolio: Portfolio
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
