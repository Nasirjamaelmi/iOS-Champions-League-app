//
//  Fanstasyleague.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

import Foundation

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
