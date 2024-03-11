//
//  ChampionsleaugeModelTests.swift
//  championsleagueTests
//
//  Created by Nasir Jama Elmi on 2024-03-11.
//

import XCTest
@testable import championsleague

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
