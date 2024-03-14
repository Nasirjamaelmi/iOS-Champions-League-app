//
//  ChampionsleaugeModelTests.swift
//  championsleagueTests
//
//  Created by Nasir Jama Elmi on 2024-03-11.
//

import XCTest
@testable import championsleague
import SwiftData
//https://chat.openai.com/share/2a285704-3088-4dd5-a1fe-c76ec7dd9aeb diffculty finding more unittest other then them or swiftdata which gets complicated if we use it because of like modelcontext
final class ChampionsleaugeModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /*func testExample() throws {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
     // Any test you write for XCTest can be annotated as throws and async.
     // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
     // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
     
     
     }*/
    
    func testProcessStats() {
        FantasyStatsProcessor.fantasyPlayers = [:]
        var fantasyPlayers: [Int: PlayerFantasyStats] = [:]
        
        let topList1 = TopList(StatName: .goals, Title: "Top Scorers", Subtitle: "Season", LocalizedTitleId: "top_scorers", LocalizedSubtitleId: "season", StatList: [
            Players(ParticipantName: "Player1", ParticiantId: 1, TeamId: 101, TeamColor: "Red", StatValue: 5.0, SubStatValue: 0.0, MinutesPlayed: 90, MatchesPlayed: 10, StatValueCount: 1, Rank: 1, ParticipantCountryCode: "US", TeamName: "Team A")
        ])
        
        let topList2 = TopList(StatName: .assists, Title: "Top Assists", Subtitle: "Season", LocalizedTitleId: "top_assists", LocalizedSubtitleId: "season", StatList: [
            Players(ParticipantName: "Player2", ParticiantId: 2, TeamId: 102, TeamColor: "Blue", StatValue: 8.0, SubStatValue: 0.0, MinutesPlayed: 90, MatchesPlayed: 10, StatValueCount: 1, Rank: 1, ParticipantCountryCode: "UK", TeamName: "Team B")
        ])
        
        let topLists = [topList1, topList2]
        
        FantasyStatsProcessor.processStats(from: topLists)
        
        XCTAssertEqual(FantasyStatsProcessor.fantasyPlayers.count, 2)
        
        // Test if the stats are processed correctly
        XCTAssertEqual(FantasyStatsProcessor.fantasyPlayers[1]?.stats[.goals], 5.0)
        XCTAssertEqual(FantasyStatsProcessor.fantasyPlayers[2]?.stats[.assists], 8.0)
        
    }
    
    func testGetLeaderboard() {
        FantasyStatsProcessor.fantasyPlayers = [:]
        var fantasyPlayers: [Int: PlayerFantasyStats] = [:]
        // Assuming fantasyPlayers is already populated with some data
        // Add sample data for testing
        let player1 = PlayerFantasyStats(ParticipantName: "Player1", ParticiantId: 1, name: "Player1", id: 1, stats: [.goals: 5.0, .assists: 3.0])
        let player2 = PlayerFantasyStats(ParticipantName: "Player2", ParticiantId: 2, name: "Player2", id: 2, stats: [.goals: 3.0, .assists: 5.0])
        
        FantasyStatsProcessor.fantasyPlayers = [1: player1, 2: player2]
        
        let leaderboard = FantasyStatsProcessor.getLeaderboard()
        
        // Test if the leaderboard is sorted correctly
        XCTAssertEqual(leaderboard.count, 2)
        XCTAssertEqual(leaderboard[0].id, 1) // Player2 has more points
        XCTAssertEqual(leaderboard[1].id, 2)
        
    }
}
class FantasyLeagueTests: XCTestCase {
    
    func testPointsValueForGoals() {
        let goalsStatType = StatType.goals
        
        XCTAssertEqual(goalsStatType.pointsValue(for: 5.0), 50)
        XCTAssertEqual(goalsStatType.pointsValue(for: 3.0), 30)
        XCTAssertEqual(goalsStatType.pointsValue(for: 0.0), 0)
        
    }
    
    func testPointsValueForAssists() {
        let assistsStatType = StatType.assists
        
        XCTAssertEqual(assistsStatType.pointsValue(for: 5.0), 25)
        XCTAssertEqual(assistsStatType.pointsValue(for: 3.0), 15)
        XCTAssertEqual(assistsStatType.pointsValue(for: 0.0), 0)
        
    }
    
    func testPointsValueForYellowCards() {
        let yellowCardsStatType = StatType.yellowCards
        
        XCTAssertEqual(yellowCardsStatType.pointsValue(for: 5.0), -25)
        XCTAssertEqual(yellowCardsStatType.pointsValue(for: 3.0), -15)
        XCTAssertEqual(yellowCardsStatType.pointsValue(for: 0.0), 0)
        
    }
    
    func testPointsValueForRedCards() {
        let redCardsStatType = StatType.redCards
        
        XCTAssertEqual(redCardsStatType.pointsValue(for: 5.0), -50)
        XCTAssertEqual(redCardsStatType.pointsValue(for: 3.0), -30)
        XCTAssertEqual(redCardsStatType.pointsValue(for: 0.0), 0)
        
    }
    
    func testPointsValueForCleanSheets() {
        let cleanSheetsStatType = StatType.cleanSheets
        
        XCTAssertEqual(cleanSheetsStatType.pointsValue(for: 5.0), 50)
        XCTAssertEqual(cleanSheetsStatType.pointsValue(for: 3.0), 30)
        XCTAssertEqual(cleanSheetsStatType.pointsValue(for: 0.0), 0)
    }
}

// doing unit test on the model
class ChampionsLeagueDataTests: XCTestCase {
    
    func testDecoding() throws {
        // Given
        let json = """
        {
            "details": {
                "id": 1,
                "type": "League",
                "name": "Champions League",
                "selectedSeason": "2023/2024",
                "latestSeason": "2023/2024",
                "shortName": "UCL",
                "country": "Europe"
            },
            "table": [],
            "matches": {
                "allMatches": []
            }
        }
        """.data(using: .utf8)!
        
        // When
        let championsLeagueData = try JSONDecoder().decode(ChampionsLeagueData.self, from: json)
        
        // Then
        XCTAssertEqual(championsLeagueData.details.id, 1)
        XCTAssertEqual(championsLeagueData.details.type, "League")
        XCTAssertEqual(championsLeagueData.details.name, "Champions League")
        XCTAssertEqual(championsLeagueData.details.selectedSeason, "2023/2024")
        XCTAssertEqual(championsLeagueData.details.latestSeason, "2023/2024")
        XCTAssertEqual(championsLeagueData.details.shortName, "UCL")
        XCTAssertEqual(championsLeagueData.details.country, "Europe")
        XCTAssertTrue(championsLeagueData.table.isEmpty)
        XCTAssertTrue(championsLeagueData.matches.allMatches.isEmpty)
    }
    
    func testMatchStatusDecoding() throws {
        // Given
        let json = """
        {
            "details": {
                "id": 1,
                "type": "League",
                "name": "Champions League",
                "selectedSeason": "2023/2024",
                "latestSeason": "2023/2024",
                "shortName": "UCL",
                "country": "Europe"
            },
            "table": [],
            "matches": {
                "firstUnplayedMatch": {
                    "firstRoundWithUnplayedMatch": 1,
                    "firstUnplayedMatchIndex": 0,
                    "firstUnplayedMatchId": "123"
                },
                "allMatches": [
                    {
                        "round": 1,
                        "roundName": "Round 1",
                        "pageUrl": "https://example.com/match/1",
                        "id": "123",
                        "home": {"name": "Team A", "shortName": "A", "id": "1"},
                        "away": {"name": "Team B", "shortName": "B", "id": "2"},
                        "status": {"utcTime": "2024-03-01T20:00:00", "finished": false, "started": true, "cancelled": false, "scoreStr": null, "reason": null}
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        // When
        let championsLeagueData = try JSONDecoder().decode(ChampionsLeagueData.self, from: json)
        
        // Then
        XCTAssertEqual(championsLeagueData.matches.allMatches.count, 1)
        let match = championsLeagueData.matches.allMatches[0]
        XCTAssertEqual(match.status.utcTime, "2024-03-01T20:00:00")
        XCTAssertFalse(match.status.finished)
        XCTAssertTrue(match.status.started)
        XCTAssertFalse(match.status.cancelled)
        XCTAssertNil(match.status.scoreStr)
        XCTAssertNil(match.status.reason)
    }
}



class PlayerFantasyStatsTests: XCTestCase {
    
    func testTotalPointsCalculation() {
        // Create sample stats
        let stats: [StatType: Double] = [.goals: 2, .assists: 1, .yellowCards: 1, .redCards: 0, .cleanSheets: 0]
        
        // Create a PlayerFantasyStats instance
        let playerStats = PlayerFantasyStats(ParticipantName: "John", ParticiantId: 1, name: "John Doe", id: 123, stats: stats)
        
        // Calculate expected total points
        let expectedTotalPoints = (2 * 10) + (1 * 5) + (1 * -5) + (0 * -10) + (0 * 10)
        
        // Verify total points calculation
        XCTAssertEqual(playerStats.totalPoints, expectedTotalPoints)
    }
    
    func testTotalPointsWithMissingStat() {
        // Create sample stats with missing stat
        let stats: [StatType: Double] = [.goals: 2, .assists: 1, .yellowCards: 1]
        
        // Create a PlayerFantasyStats instance
        let playerStats = PlayerFantasyStats(ParticipantName: "John", ParticiantId: 1, name: "John Doe", id: 123, stats: stats)
        
        // Expected points without the missing stat (cleanSheets)
        let expectedTotalPoints = (2 * 10) + (1 * 5) + (1 * -5)
        
        // Verify total points calculation
        XCTAssertEqual(playerStats.totalPoints, expectedTotalPoints)
    }
    
    func testProcessStatsUpdatesExistingPlayerStats() {
        // Given
        FantasyStatsProcessor.fantasyPlayers = [:]
        let initialStats: [StatType: Double] = [.goals: 5.0, .assists: 3.0]
        let existingPlayer = PlayerFantasyStats(ParticipantName: "Player1", ParticiantId: 1, name: "Player1", id: 1, stats: initialStats)
        FantasyStatsProcessor.fantasyPlayers[1] = existingPlayer
        
        let topList = TopList(StatName: .goals, Title: "Top Scorers", Subtitle: "Season", LocalizedTitleId: "top_scorers", LocalizedSubtitleId: "season", StatList: [
            Players(ParticipantName: "Player1", ParticiantId: 1, TeamId: 101, TeamColor: "Red", StatValue: 2.0, SubStatValue: 0.0, MinutesPlayed: 90, MatchesPlayed: 10, StatValueCount: 1, Rank: 1, ParticipantCountryCode: "US", TeamName: "Team A")
        ])
        
        // When
        FantasyStatsProcessor.processStats(from: [topList])
        
        // Then
        XCTAssertEqual(FantasyStatsProcessor.fantasyPlayers.count, 1)
        XCTAssertEqual(FantasyStatsProcessor.fantasyPlayers[1]?.stats[.goals], 7.0) // Existing goals (5.0) + New goals (2.0)
        XCTAssertEqual(FantasyStatsProcessor.fantasyPlayers[1]?.stats[.assists], 3.0) // Existing assists (3.0)
    }
}





