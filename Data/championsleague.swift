    //
    //  championsleague.swift
    //  championsleague
    //
    //  Created by Zachery Arscott on 2024-02-19.
    //

    import Foundation

    struct ChampionsLeagueData: Decodable  {
        let details: LeagueDetails
        let table: [TableData]
        let matches: MatchData
        
        
        struct LeagueDetails: Decodable {
            let id: Int
            let type: String
            let name: String
            let selectedSeason: String
            let latestSeason: String
            let shortName: String
            let country: String
        }
        
        struct TableData: Decodable{
            let data: TableDataContent
            
            struct TableDataContent: Decodable {
                let composite: Bool
                let ccode: String
                let leagueId: Int
                let pageUrl: String
                let leagueName: String
                let legend: [Legend]
                let tables: [GroupTable]
                
                struct Legend: Decodable {
                    let title: String
                    let tKey: String
                    let color: String
                    let indices: [Int]
                }
                
                struct GroupTable: Decodable {
                    let ccode: String
                    let leagueId: Int
                    let pageUrl: String
                    let leagueName: String
                    let legend: [Legend]
                    let table: Group
                    
                    struct Group: Decodable {
                        let all: [Team]
                        
                        struct Team: Decodable, Identifiable {
                            let name: String
                            let shortName: String
                            let id: Int
                            let pageUrl: String
                            let played: Int
                            let wins: Int
                            let draws: Int
                            let losses: Int
                            let scoresStr: String
                            let goalConDiff: Int
                            let pts: Int
                            let idx: Int
                            
                            
                            var idString: String {
                                "\(id)"
                            }
                        }
                    }
                }
            }
        }
        
        
        
        struct MatchData: Decodable {
            let firstUnplayedMatch: FirstUnplayedMatch
            let allMatches: [Match]
            
            struct FirstUnplayedMatch: Decodable {
                let firstRoundWithUnplayedMatch: Int
                let firstUnplayedMatchIndex: Int
                let firstUnplayedMatchId: String
            }
            
            struct Match: Decodable, Identifiable {
                let round: Int
                let roundName: String
                let pageUrl: String
                let id: String
                let home: Team
                let away: Team
                let status: Status
                
                enum CodingKeys: String, CodingKey {
                    case round, roundName, pageUrl, id, home, away, status
                }
                
                init(from decoder: Decoder) throws {
                    let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
                    self.round = try container.decode(Int.self, forKey: .round)
                    self.pageUrl = try container.decode(String.self, forKey: .pageUrl)
                    self.home = try container.decode(Team.self, forKey: .home)
                    self.id = try container.decode(String.self, forKey: .id)
                    self.away = try container.decode(Team.self, forKey: .away)
                    self.status = try container.decode(Status.self, forKey: .status)
                    do{
                        roundName = try String(container.decode(Int.self, forKey: .roundName))
                    }catch DecodingError.typeMismatch{
                        roundName = try container.decode(String.self, forKey: .roundName)
                    }
                }
                
                struct Team: Decodable {
                    let name: String
                    let shortName: String
                    let id: String
                }
                
                struct Status: Decodable {
                    let utcTime: String
                    let finished: Bool
                    let started: Bool
                    let cancelled: Bool
                    let scoreStr: String?
                    let reason: Reason?
                    
                    struct Reason: Decodable {
                        let short: String
                        let shortKey: String
                        let long: String
                        let longKey: String
                    }
                }
            }
        }
    }

