    //
    //  Fanstasyleague.swift
    //  championsleague
    //
    //  Created by Zachery Arscott on 2024-02-28.
    //

    import Foundation
    import SwiftData


    struct FanstasyleagueData: Decodable {
        let TopLists: [TopList]
       
    }


    struct TopList: Decodable {
        let StatName: StatType
        let Title: String
        let Subtitle: String
        let LocalizedTitleId: String
        let LocalizedSubtitleId: String
        let StatList: [Players]
    }

    struct Players: Decodable {
        
        let ParticipantName: String
        let ParticiantId: Int
        let TeamId: Int
        let TeamColor: String
        let StatValue: Double
        let SubStatValue: Double
        let MinutesPlayed: Int
        let MatchesPlayed: Int
        let StatValueCount: Int
        let Rank: Int
        let ParticipantCountryCode: String
        let TeamName: String
    }


    enum StatType: String, Decodable {
            case goals = "goals",
                 assists = "goal_assist",
                 yellowCards = "yellow_card",
                 redCards = "red_cards",
                 cleanSheets = "clean_sheet"
        
        
        func pointsValue(for statValue: Double) -> Int {
            switch self {
            case .goals: return Int(statValue) * 10
            case .assists: return Int(statValue) * 5
            case .yellowCards: return Int(statValue) * -5
            case .redCards: return Int(statValue) * -10
            case .cleanSheets: return Int(statValue) * 10
            }
        }
    }

    struct PlayerFantasyStats: Decodable, Identifiable {
        let ParticipantName: String
        let ParticiantId: Int
        let name: String
        let id: Int
        var stats: [StatType: Double] = [:]
        
        var totalPoints: Int {
            stats.reduce(0) { total, stat in
                total + stat.key.pointsValue(for: stat.value)
            }
        }
    }



    class FantasyStatsProcessor {
        static var fantasyPlayers: [Int: PlayerFantasyStats] = [:]
        
        static func processStats(from topLists: [TopList]) {
            for topList in topLists {
                for player in topList.StatList {
                    let statValue = player.StatValue
                    
                    if var existingPlayerStats = fantasyPlayers[player.ParticiantId] {
                  
                        if let currentStatValue = existingPlayerStats.stats[topList.StatName] {
                            existingPlayerStats.stats[topList.StatName] = currentStatValue + statValue
                        } else {
                            existingPlayerStats.stats[topList.StatName] = statValue
                        }
                        fantasyPlayers[player.ParticiantId] = existingPlayerStats
                    } else {
                        var newPlayerStats = PlayerFantasyStats(ParticipantName: player.ParticipantName, ParticiantId: player.ParticiantId, name: player.ParticipantName, id: player.ParticiantId)
                        newPlayerStats.stats[topList.StatName] = statValue
                        fantasyPlayers[player.ParticiantId] = newPlayerStats
                    }
                }
            }
        }
        
        
        static func getLeaderboard() -> [PlayerFantasyStats] {
            let sortedPlayers = fantasyPlayers.values.sorted { $0.totalPoints > $1.totalPoints }
            return sortedPlayers
        }
    }



    /*
    // Player.swift
    @Model
    struct Player: Identifiable {
      let id: Int
      let name: String
      let price: Double
      var fantasyStats: [StatType: Double] // Dictionary to store player's stats for different categories

      // Additional player properties like team, position (optional)

      init(id: Int, name: String, price: Double, fantasyStats: [StatType: Double]) {
        self.id = id
        self.name = name
        self.price = price
        self.fantasyStats = fantasyStats
      }
    }

    // Transaction.swift
    @Model
    struct Transaction {
      let id: UUID
      let user: User // Relationship to User model
      let player: Player // Relationship to User model
      let buy: Bool // Flag to indicate buy (true) or sell (false) transaction
      let price: Double

      init(id: UUID = UUID(), user: User, player: Player, buy: Bool, price: Double) {
        self.id = id
        self.user = user
        self.player = player
        self.buy = buy
        self.price = price
      }
    }

    // User.swift
    @Model
    class User: Identifiable {
      let id: UUID
      let username: String
        var budget: Double // 5 million in your case
      var selectedPlayerIds: [Int] // Array of player IDs



      init(id: UUID = UUID(), username: String, budget: Double, selectedPlayerIds: [Int] = []) {
        self.id = id
        self.username = username
        self.budget = budget
        self.selectedPlayerIds = selectedPlayerIds
      }

      // Function to check if a player can be bought
      func canBuy(player: Player) -> Bool {
        return budget >= player.price && selectedPlayerIds.count < 5
      }

      // Function to perform buying a player
      func buyPlayer(player: Player, context: ModelContext) throws {
        guard canBuy(player: player) else {
          throw NSError(domain: "FantasyLeagueError", code: 1, userInfo: ["message": "Insufficient budget or maximum players reached"])
        }
        budget -= player.price
        selectedPlayerIds.append(player.id)
        try context.save()
      }

      // Function to perform selling a player
      func sellPlayer(player: Player, context: ModelContext) throws {
        guard selectedPlayerIds.contains(player.id) else {
          throw NSError(domain: "FantasyLeagueError", code: 2, userInfo: ["message": "Player not found in selected players"])
        }
        budget += player.price
        selectedPlayerIds.removeAll(where: { $0 == player.id })
        try context.save()
      }
    }

    */
