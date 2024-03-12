//
//  Fanstasyleague.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

import Foundation
import SwiftData
import StoreKit
import FirebaseAuth


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


enum StatType: String, Codable {
        case goals = "goals",
             assists = "goal_assist",
             yellowCards = "yellow_card",
             redCards = "red_card",
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





@Model
final class Player: Identifiable {
    let id: Int64
    var name: String
    var price: Double
    var fantasyStats: [StatType: Double] = [:]
    
    
    var fantasyPoints: Int {
            fantasyStats.reduce(0) { total, stat in
                total + stat.key.pointsValue(for: stat.value)
            }
        }
    
    var computedPrice: Double {
            Double(fantasyPoints * 50000)
        }
    
    init(id: Int64, name: String, price: Double, fantasyPoints: [StatType: Double] = [:]) {
        self.id = id
        self.name = name
        self.price = price
        self.fantasyStats = fantasyStats
        
    }
    
    func updateStat(type: StatType, value: Double) {
            fantasyStats[type, default: 0] += value
        self.price = computedPrice
        }

        // New method to update fantasy stats in bulk
        func updateFantasyStats(newStats: [StatType: Double]) {
            for (statType, newValue) in newStats {
                updateStat(type: statType, value: newValue)
            }
        }
}





@Model
class Usera {
    let id: UUID = UUID()
    var username: String
    var budget: Double
    var transactions: [Transaction] = []

    init(id: UUID = UUID(),username: String, budget: Double) {
        self.id = id
        self.username = username
        self.budget = budget
    }
}



@Model
class Transaction {
    let id: UUID = UUID()
    var player: Player
    var user: Usera
    var isPurchase: Bool
    var transactionDate: Date
    
    init(player: Player, user: Usera, isPurchase: Bool, transactionDate: Date = Date()) {
        self.player = player
        self.user = user
        self.isPurchase = isPurchase
        self.transactionDate = transactionDate
    }
}


