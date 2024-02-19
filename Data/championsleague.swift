//
//  championsleague.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-19.
//

import Foundation

struct ChampionsLeagueData: Decodable {
    let matches: [Match]
    let standings: [Standing]
    let groupTables: [GroupTable]
    
    enum CodingKeys: String, CodingKey {
        case matches, standings, groupTables = "tables"
    }
    
    
    struct Match: Decodable, Identifiable {
        let id: String
        let date: String
        let homeTeam: TeamDetail
        let awayTeam: TeamDetail
        let score: ScoreDetail?
        
        enum CodingKeys: String, CodingKey {
            case id, date, homeTeam, awayTeam, score
        }
        
        
        struct TeamDetail: Decodable {
            let name: String
            let id: String
            
            enum CodingKeys: String, CodingKey {
                case name, id
            }
        }
        
        
        struct ScoreDetail: Decodable {
            let fullTime: String?
            let halfTime: String?
            
            enum CodingKeys: String, CodingKey {
                case fullTime = "full_time"
                case halfTime = "half_time"
            }
        }
    }
    
    
    struct Standing: Decodable, Identifiable {
        let id: String
        let team: String
        let playedGames: Int
        let wins: Int
        let draws: Int
        let losses: Int
        let points: Int
        
        enum CodingKeys: String, CodingKey {
            case id, team, playedGames = "played_games", wins, draws, losses, points
        }
    }
    
    
    struct GroupTable: Decodable {
        let ccode: String
        let leagueId: Int
        let pageUrl: String
        let leagueName: String
        let legend: [Legend]
        
        enum CodingKeys: String, CodingKey {
            case ccode, leagueId, pageUrl, leagueName, legend
        }
        
        
        struct Legend: Decodable {
            let position: Int
            let description: String
            
            enum CodingKeys: String, CodingKey {
                case position, description
            }
        }
    }
    
    // MARK: - Fantasy League Player Stats Structure
    struct PlayerStats: Decodable, Identifiable {
        var playerId: String
        var playerName: String
        var teamId: String
        var teamName: String
        var gamesPlayed: Int
        var goals: Int
        var assists: Int
        var shotsOnTarget: Int
        var passingAccuracy: Double
        var yellowCards: Int
        var redCards: Int

        enum CodingKeys: String, CodingKey {
            case playerId = "player_id"
            case playerName = "player_name"
            case teamId = "team_id"
            case teamName = "team_name"
            case gamesPlayed = "games_played"
            case goals, assists
            case shotsOnTarget = "shots_on_target"
            case passingAccuracy = "passing_accuracy"
            case yellowCards = "yellow_cards"
            case redCards = "red_cards"
        }

        var id: String { playerId }
    }
}
    


