//
//  StagesScreen.swift
//  championsleague
//
//  Created by Nasir Jama elmi on 2024-03-01.
//

import SwiftUI

struct StagesScreen: View {
    let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
    let footballModel = FootballModel()
    
    var finishedMatches: [ChampionsLeagueData.MatchData.Match] {
        footballModel.footballData?.matches.allMatches.filter { $0.status.started } ?? []
    }
    var body: some View {
        Text("Hello")
    }
    
}
#Preview {
    StagesScreen()
}

