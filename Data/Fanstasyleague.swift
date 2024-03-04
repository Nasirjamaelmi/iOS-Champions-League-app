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
    let StatName: String
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
