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

@Observable
class FantasyLeagueViewModel{
    var user: User
    var availablePlayers: [Player]
    
    
    private var fantasyModel = FantasyModel()

    init() {
        self.user = User(username: "default", budget: 3_000_000) // A budget allowing the purchase of 5 average players without being overpowered
        self.availablePlayers = []
    }

    func loadData() async {
        await fantasyModel.loadAllData()
        // Assuming FantasyStatsProcessor is updated within the loadAllData call
        
        // Convert processed stats into Player models
        DispatchQueue.main.async {
            self.availablePlayers = self.processFantasyDataIntoPlayers()
            
        }
    }

    private func processFantasyDataIntoPlayers() -> [Player] {
        var players: [Player] = []
        for (_, playerStats) in FantasyStatsProcessor.fantasyPlayers {
            let newPlayer = Player(
                id: Int64(playerStats.id),
                name: playerStats.name,
                price: 0, // Initial price is 0; will be computed based on stats
                fantasyPoints: playerStats.stats
            )
            // Recalculate player's price based on fantasy points
            newPlayer.price = newPlayer.computedPrice
            players.append(newPlayer)
        }
        return players
    }

    func canBuyPlayer(player: Player) -> Bool {
        return user.budget >= player.price && user.transactions.count < 5
    }

    func buyPlayer(player: Player) {
        guard canBuyPlayer(player: player) else { return }

        let transaction = Transaction(player: player, user: user, isPurchase: true)
        user.budget -= player.price
        user.transactions.append(transaction)
    
  
    }

    func sellPlayer(player: Player) {
        guard let transactionIndex = user.transactions.firstIndex(where: {$0.player.id == player.id && $0.isPurchase}) else { return }
        
        user.budget += player.price // Assume selling back at the same price for simplicity
        user.transactions.remove(at: transactionIndex)
        
     
   
    }
}
