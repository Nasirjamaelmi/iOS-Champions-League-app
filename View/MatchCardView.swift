//
//  MatchCardView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-26.
//

import SwiftUI

struct MatchCardView: View {
    let match: ChampionsLeagueData.MatchData.Match?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 200, height: 120)
                .foregroundStyle(.green)
            
            HStack {
                Text(match?.home.name ?? "Barca")
                
                Text(match?.status.scoreStr ?? "2-2")
                
                Text(match?.away.name ?? "City")
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    
    MatchCardView(match: nil)
}
