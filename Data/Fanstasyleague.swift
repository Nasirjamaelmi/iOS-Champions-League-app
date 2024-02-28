//
//  Fanstasyleague.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

import Foundation

struct FanstasyleagueData: Decodable {
    let topLists: [TopList]
    let leagueName: String
}


struct TopList: Decodable {
    let statName: String
    let title: String
    let subtitle: String
    let localizedTitleId: String
    let localizedSubtitleId: String
    let statList: [Players]
}

struct Players: Decodable {
    let participantName: String
    let participantId: Int
    let teamId: Int
    let teamColor: String
    let statValue: Double
    let subStatValue: Double
    let minutesPlayed: Int
    let matchesPlayed: Int
    let statValueCount: Int
    let rank: Int
    let participantCountryCode: String
    let teamName: String
}
