//
//  fantasyleaderboard.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

import Foundation
import SwiftUI



struct LeaderboardView: View {
    let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
    let players: [PlayerFantasyStats]

    var body: some View {
        NavigationView {
            List(players.indices, id: \.self) { index in
                HStack(spacing: 20) {
                    // Rank
                    Text("\(index + 1)")
                        .bold()
                        .frame(minWidth: 30, alignment: .leading)
                    PlayerPicView(playerId: players[index].ParticiantId)
                    VStack(alignment: .leading) {
                        Text(players[index].name)
                            .font(.headline)
                    }

                    Spacer()
                    
                    
                    Text("\(players[index].totalPoints) pts")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if index >= 30 {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.red)
                    }
                    else{
                        Image(systemName: "arrow.up")
                            .foregroundColor(.green)
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}



struct PlayerPicView: View {
    let playerId: Int

    var body: some View {
        let imageUrl = "https://images.fotmob.com/image_resources/playerimages/\(playerId).png"
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 40, height: 40)
                     .clipShape(Circle())
                     .shadow(radius: 2)
            case .failure:
                Image(systemName: "person.crop.circle.badge.xmark")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
            @unknown default:
                EmptyView()
            }
        }
    }
}



