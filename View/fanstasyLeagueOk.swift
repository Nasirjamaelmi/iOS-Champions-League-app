//
//  fanstasyLeagueOk.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-03-11.
//

import SwiftUI
import SwiftData

struct FantasyLeagueView: View {
    @Query private var transactions: [Transaction]
    @State var viewModel: FantasyLeagueViewModel
    @State private var selectedTab = 0
    @State private var isDataLoaded = false
    @State private var searchText = "" // 1. State to hold search text

        // Computed property to filter players based on search text
        private var filteredPlayers: [Player] {
            if searchText.isEmpty {
                return viewModel.availablePlayers
            } else {
                return viewModel.availablePlayers.filter { player in
                    player.name.lowercased().contains(searchText.lowercased())
                }
            }
        }

        var body: some View {
            TabView(selection: $selectedTab) {
                NavigationView {
                    List {
                        Section(header: Text("Available Players")) {
                            TextField("Search Players", text: $searchText) // 3. Search bar
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            ForEach(filteredPlayers) { player in // 4. Use filtered list
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(player.name)
                                            .font(.headline)
                                        Text("Fantasy Points: \(player.fantasyPoints)")
                                        Text("Price: \(player.price, specifier: "%.2f")")
                                    }
                                    Spacer()
                                    if viewModel.canBuyPlayer(player: player) {
                                        Button("Buy") {
                                            viewModel.buyPlayer(player: player)
                                        }
                                        .buttonStyle(.borderedProminent)
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Available Players")
                    .onAppear {
                        Task {
                            if !isDataLoaded {
                                await viewModel.loadData()
                                isDataLoaded = true
                            }
                        }
                    }
                }
                .tabItem {
                    Label("Market", systemImage: "dollarsign.circle")
                }
                .tag(0)
            
            NavigationView {
                List {
                    if let user = viewModel.user {
                        Section(header: Text("Your Roster")) {
                            ForEach(transactions.filter { $0.isPurchase }, id: \.player.id) { transaction in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(transaction.player.name)
                                        // Display the player's price in your roster
                                        Text("Price: \(transaction.player.price, specifier: "%.2f")")
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                    Button("Sell") {
                                        viewModel.sellPlayer(player: transaction.player)
                                        // Consider refreshing or updating the list to reflect the sale
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                        }
                        
                        Section {
                            Text("Budget: \(user.budget, specifier: "%.2f")")
                                .font(.title)
                        }
                    }
                }
                .navigationTitle("Your Roster")
            }
            .tabItem {
                Label("Roster", systemImage: "person.3.fill")
            }
            .tag(1)
        }
    }
}



/*
// Mock ViewModel for Preview
class MockFantasyLeagueViewModel: FantasyLeagueViewModel {
    override init() {
        super.init()
        self.availablePlayers = [
            Player(id: 1, name: "Player One", price: 100000, fantasyPoints: [.goals: 5]),
            Player(id: 2, name: "Player Two", price: 100000, fantasyPoints: [.assists: 7])
        ]
        // Recalculate price based on updated fantasy stats
        self.availablePlayers.forEach { $0.price = $0.computedPrice }
    }
}


// Preview
struct FantasyLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        FantasyLeagueView(viewModel: MockFantasyLeagueViewModel())
    }
}
*/
