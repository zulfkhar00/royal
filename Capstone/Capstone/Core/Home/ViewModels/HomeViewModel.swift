//
//  HomeViewModel.swift
//  Capstone
//
//  Created by Zulfkhar Maukey on 23.07.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    @Published var user: User? = nil
    @Published var userLoggedIn: Bool = false
    @Published var walletBalance: Double = 0.0
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
//    private let portfolioDataService = PortfolioDataService()
    private let walletDataService = WalletDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // updates allCoins whether it is filtered or just downloaded
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    func addRegularUserSubscribtion() {
        $user
            .map(mapPortfolioCoinsToAllCoins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedUser, returnedCoins in
                guard let updatedUserInfo = receivedUser, let self = self else {
                    self?.userLoggedIn = false
                    return
                }
                self.userLoggedIn = true
                self.walletDataService.set(user: updatedUserInfo)
                self.walletBalance = updatedUserInfo.wallet.balance
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
    }
    
    func addArtistSubscription() {
        $user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedUser in
                guard let updatedUserInfo = receivedUser, let self = self else {
                    self?.userLoggedIn = false
                    return
                }
                self.userLoggedIn = true
                self.walletDataService.set(user: updatedUserInfo)
                self.walletBalance = updatedUserInfo.wallet.balance
                reloadData()
                self.portfolioCoins = self.allCoins.filter { coin in
                    updatedUserInfo.publishedCoins.contains { publishedCoin in
                        return coin.id == publishedCoin.coinID
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func reloadData() {
        coinDataService.getCoins()
        marketDataService.getData()
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        // sort
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // will only sort by holdings or holdingsReversed if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapPortfolioCoinsToAllCoins(userInfo: User?) -> (User?, [CoinModel]) {
        return (
            userInfo,
            allCoins.compactMap { coin -> CoinModel? in
                guard let stock = userInfo?.portfolio.stocks.first(where: { $0.id == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: stock.amount)
            }
        )
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingsValue }).reduce(0, +)
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue/(1 + percentChange)
                return previousValue
            }.reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange
        )
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
    
    func coinExistsInPortfolio(coin: CoinModel) -> Bool {
        return portfolioCoins.contains { $0.id == coin.id }
    }
    
    func amountOfCoinInPortfolio(coin: CoinModel) -> Double {
        guard let foundMusicStock = user?.portfolio.stocks.first(where: { $0.id == coin.id }) else {
            return 0.0
        }
        return foundMusicStock.amount
    }
    
    func payFromWallet(amount: Double) {
        walletDataService.syncWalletBalance(balance: walletBalance - amount) { updatedUserInfo in
            self.user = updatedUserInfo
        }
    }
    
    func addMoneyToWallet(amount: Double) {
        walletDataService.syncWalletBalance(balance: walletBalance + amount) { updatedUserInfo in
            self.user = updatedUserInfo
        }
    }
    
    func addCoinToPortfolio(coin: CoinModel, amount: Double) {
        var finalAmount: Double = amount
        if let portfolioCoin = user?.portfolio.stocks.first(where: { $0.id == coin.id }) {
            finalAmount = portfolioCoin.amount + amount
        } else {
            user?.portfolio.stocks.append(MusicStock(id: coin.id, amount: finalAmount))
        }
        walletDataService.syncPortfolioCoin(coin: coin, amount: finalAmount) { updatedUserInfo in
            self.user = updatedUserInfo
        }
    }
    
    func sellCoinFromPortfolio(coin: CoinModel, amount: Double) {
        guard var portfolioCoin = user?.portfolio.stocks.first(where: { $0.id == coin.id }) else {
            return
        }
        portfolioCoin.amount -= amount
        walletDataService.syncPortfolioCoin(coin: coin, amount: portfolioCoin.amount) { updatedUserInfo in
            self.user = updatedUserInfo
        }
    }
    
    func portfolioHasSufficient(amount: Double, of coin: CoinModel) -> Bool {
        return (user?.portfolio.stocks.first(where: { $0.id == coin.id })?.amount ?? 0) >= amount
    }
    
    // Artist methods
    func publishSong() {
        let newSongCoin = CoinModel(
            id: UUID().uuidString,
            symbol: String.randomString(length: 6),
            name: String.randomString(length: 6),
            image: "https://picsum.photos/200",
            currentPrice: 50,
            marketCap: 0,
            marketCapRank: 0,
            fullyDilutedValuation: 0,
            totalVolume: 0,
            high24H: 0,
            low24H: 0,
            priceChange24H: 0,
            priceChangePercentage24H: 0,
            marketCapChange24H: 0,
            marketCapChangePercentage24H: 0,
            circulatingSupply: 0,
            totalSupply: 0,
            maxSupply: 0,
            ath: 0,
            athChangePercentage: 0,
            athDate: "",
            atl: 0,
            atlChangePercentage: 0,
            atlDate: "",
            lastUpdated: "",
            sparklineIn7D: nil,
            priceChangePercentage24HInCurrency: 0,
            currentHoldings: nil
        )
        walletDataService.syncPublishSong(coin: newSongCoin) { updatedUserInfo in
            self.user = updatedUserInfo
        }
    }
    
}

// MARK: Registration/Authroization Logic
extension HomeViewModel {
    
    func registerUser(name: String, email: String, password: String, isArtist: Bool) {
        if isArtist {
            addArtistSubscription()
        } else {
            addRegularUserSubscribtion()
        }
        
        guard let url = URL(string: "http://localhost:4000/register?name=\(name)&email=\(email)&password=\(password)&is_artist=\(isArtist)") else {
            return
        }
        
        NetworkingManager.download(url: url)
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] registeredUser in
                self?.user = registeredUser
            })
            .store(in: &cancellables)
    }
    
    func loginUser(email: String, password: String) {
        guard let url = URL(string: "http://localhost:4000/login?email=\(email)&password=\(password)") else {
            return
        }
        
//        URLSession.shared.dataTask(with: URLRequest(url: url)) { d, _, e in
//            guard let data = d, e == nil else {
//                print("Error or didn't get data")
//                return
//            }
//
//            print(String(data: data, encoding: .utf8))
//        }.resume()
        
        NetworkingManager.download(url: url)
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] loggedUser in
                print("loginUser(:) ", loggedUser)
                if loggedUser.isArtist {
                    self?.addArtistSubscription()
                } else {
                    self?.addRegularUserSubscribtion()
                }
                self?.user = loggedUser
            })
            .store(in: &cancellables)
    }
    
}
