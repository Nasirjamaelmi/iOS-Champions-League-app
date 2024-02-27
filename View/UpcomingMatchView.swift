//
//  UpcomingMatchView.swift
//  championsleague
//
//  Created by Nasir Jama elmi on 2024-02-26.
//

import SwiftUI

struct UpcomingMatchView: View {
    let match: ChampionsLeagueData.MatchData.Match

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 300, height: 80)
                .foregroundStyle(.green)
            
            HStack {
                Text(match.home.name)
                
                // You might not have the score for upcoming matches, so adjust as needed
                Text(match.status.scoreStr ?? "vs")
                
                Text(match.away.name)
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
        }
    }
}

/*
#Preview {
    UpcomingMatchView(match: <#T##ChampionsLeagueData.MatchData.Match#>)
}
*/
