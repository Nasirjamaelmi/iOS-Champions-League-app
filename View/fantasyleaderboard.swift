//
//  fantasyleaderboard.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

import Foundation
import SwiftUI


struct LeaderboardView: View {
    let players: [PlayerFantasyStats]

    var body: some View {
        NavigationView {
            List(players.indices, id: \.self) { index in
                HStack {
                    Text(players[index].name)
                        .font(.headline)
                        .foregroundColor(index < 3 ? .blue : .primary) // Highlight top 3 players in blue
                    Spacer()
                    Text("\(players[index].totalPoints) pts")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("Fantasy League Leaderboard")
        }
        .onAppear{
            debugPrint(players)
        }
    }
}


