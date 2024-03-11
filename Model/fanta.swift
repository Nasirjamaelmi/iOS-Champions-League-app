//
//  fanta.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-03-08.
//


import Foundation
import Combine
import Observation
import SwiftData
import FirebaseAuth

@Observable
class FantasyLeagueViewModel{
    var modelContext: ModelContext
    var user: Usera?
    var availablePlayers: [Player]
    let fantasyModel: FantasyModel
    
    init(modelContext: ModelContext, user: Usera? = nil, availablePlayers: [Player], fantasyModel: FantasyModel) {
        self.modelContext = modelContext
        self.user = user
        self.availablePlayers = availablePlayers
        self.fantasyModel = fantasyModel
        
        checkForUser()
        checkUserContent()
    }
    
    private func checkUserContent() {
        guard let user = self.user else { return }
        
        print("DEBUG: User found, looping through transactions:")
        print("DEBUG: User transaction count is: \(user.transactions.count)")
        user.transactions.forEach { transaction in
            print(transaction.player.name)
        }
        
        do {
            let descriptor = FetchDescriptor<Transaction>()
            let transactions = try modelContext.fetch(descriptor)
            print("DEBUG: stored transactions are: ")
            transactions.forEach { transaction in
                print(transaction.player.name)
            }
        } catch {
            print("Failed fetching transactions")
        }
    }
    
    private func updateUser() {
        do {
            let descriptor = FetchDescriptor<Usera>()
            let users = try modelContext.fetch(descriptor)
            guard let user = users.first, users.count == 1 else { fatalError("Found more than 1 user") }
            self.user = user
        } catch {
            print("failed to fetch users from modelcontext")
        }
    }
    
    private func checkForUser() {
        do {
            let descriptor = FetchDescriptor<Usera>()
            let users = try modelContext.fetch(descriptor)
            
            if users.count > 1 {
                try? modelContext.delete(model: Usera.self)
                try? modelContext.delete(model: Transaction.self)
            }
            
            if let user = users.first {
                self.user = user
                print("Found user in modelContext, will not create new user")
            } else {
                let newUser = Usera(username: "user", budget: 3000000)
                modelContext.insert(newUser)
                self.user = newUser
            }
        } catch {
            print("failed to fetch users from modelContext")
        }
    }
    
    func loadData() async {
        await fantasyModel.loadAllData()
        // Assuming FantasyStatsProcessor is updated within the loadAllData call
        
        // Convert processed stats into Player models
        Task { @MainActor in
            self.availablePlayers = self.processFantasyDataIntoPlayers()
            
        }
    }

    private func processFantasyDataIntoPlayers() -> [Player] {
        var players: [Player] = []
        for (_, playerStats) in FantasyStatsProcessor.fantasyPlayers {
            let newPlayer = Player(
                id: Int64(playerStats.id),
                name: playerStats.name,
                price: Double(playerStats.totalPoints * 50000), // Assuming computedPrice reflects total points
                fantasyPoints: playerStats.stats
            )
            players.append(newPlayer)
        }
        return players
    }


    func canBuyPlayer(player: Player) -> Bool {
        guard let user = user else { return false }
        return user.budget >= player.price && user.transactions.count < 5
    }
    
    func buyPlayer(player: Player) {
        guard let user = user, canBuyPlayer(player: player) else { return }
        
        let transaction = Transaction(player: player, user: user, isPurchase: true)
        user.budget -= player.price
        user.transactions.append(transaction)
    }
    
    func sellPlayer(player: Player){
        guard let user = user else {return}
        guard let transactionIndex = user.transactions.firstIndex(where: {$0.player.id == player.id && $0.isPurchase}) else { return }
        let sellingPrice = player.price * 0.8
        user.budget += sellingPrice
        user.transactions.remove(at: transactionIndex)
    }
    
//
//    func buyPlayer(player: Player) {
//        guard canBuyPlayer(player: player) else { return }
//
//        let transaction = Transaction(player: player, user: user, isPurchase: true)
//        user.budget -= player.price
//        user.transactions.append(transaction)
//    
//  
//    }
//
//    func sellPlayer(player: Player) {
//        guard let transactionIndex = user.transactions.firstIndex(where: {$0.player.id == player.id && $0.isPurchase}) else { return }
//        
//        let sellingPrice = player.price * 0.8 // Adjust discount factor as needed
//        user.budget += sellingPrice
//        user.transactions.remove(at: transactionIndex)
//    }

}
