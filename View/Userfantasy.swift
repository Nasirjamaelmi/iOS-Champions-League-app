//
//  Userfantasy.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-03-08.
//
/*
import Foundation
import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = FantasyLeagueViewModel()

    var body: some View {
        VStack {
            // Other view elements

            if viewModel.isLoading {
                ProgressView("Loading fantasy data...")
            } else {
                // Display available players or other data
                List {
                    ForEach(viewModel.availablePlayers) { player in
                        Text(player.name)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}
*/
