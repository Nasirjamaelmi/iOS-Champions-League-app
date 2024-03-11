//
//  fanta.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-03-08.
//
/*
import Foundation
import SwiftUI

class FantasyLeagueViewModel: ObservableObject {

  @State var user: User = User(username: "default", budget: 5000000)
  @State var availablePlayers: [Player] = []
  @State var selectedPlayers: [Player] = []

  private let fantasyModel = FantasyModel()

  func loadData() {
    fantasyModel.isLoading = { [weak self] loading in
      // Update UI to indicate loading state (optional)
      self?.objectWillChange.send()
    }

    Task {
      await fantasyModel.loadAllData()
      // Process fetched data and update availablePlayers
      availablePlayers = processFantasyData(fantasyData: fantasyModel.fantasyData)
        self.objectWillChange.send()
    }
  }

  private func processFantasyData(fantasyData: [FanstasyleagueData]) -> [Player] {
    var players: [Player] = []
    for fantasy in fantasyData {
      for topList in fantasy.TopLists {
        for playerData in topList.StatList {
          let existingPlayer = players.first(where: { $0.id == playerData.ParticiantId })
          if var existingPlayer = existingPlayer {
            // Update stats for existing player
            existingPlayer.fantasyStats[topList.StatName] = playerData.StatValue
          } else {
            // Create new player object
            let newPlayer = Player(id: playerData.ParticiantId,
                                   name: playerData.ParticipantName,
                                   price: calculatePlayerPrice(playerData: playerData), // Implement price calculation
                                   fantasyStats: [topList.StatName: playerData.StatValue])
            players.append(newPlayer)
          }
        }
      }
    }
    return players
  }

  // Implement a function to calculate player price based on your logic (optional)
  private func calculatePlayerPrice(playerData: Players) -> Double {
    // Replace with your logic to determine player price based on stats or other factors
    return 10000.0 // Placeholder value
  }

  func canBuyPlayer(player: Player) -> Bool {
    return user.canBuy(player: player) // Utilize the canBuy function from User model
  }

  func buyPlayer(player: Player) async throws {
    try await withValue { user.buyPlayer(player: player, context: $0) }
    // Update availablePlayers and selectedPlayers based on changes (optional)
    objectWillChange.send()
  }

  func sellPlayer(player: Player) async throws {
    try await withValue { user.sellPlayer(player: player, context: $0) }
    // Update availablePlayers and selectedPlayers based on changes (optional)
    objectWillChange.send()
  }
}
*/
