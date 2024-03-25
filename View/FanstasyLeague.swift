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
    @State private var searchText = ""
    
    var searchFilteredPlayers: [Player] {
            searchText.isEmpty ? viewModel.availablePlayers : viewModel.availablePlayers.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }

        var body: some View {
            TabView(selection: $selectedTab) {
                NavigationView {
                    List {
                        Section(header: Text("Available Players")) {
                            ForEach(searchFilteredPlayers, id: \.self) { player in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(player.name).font(.headline)
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
                    .searchable(text: $searchText)
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
                                       Text("Price: \(transaction.player.price, specifier: "%.2f")")
                                           .font(.subheadline)
                                                }
                                            Spacer()
                                            Button("Sell") {viewModel.sellPlayer(player: transaction.player)
                                                    
                                                }
                                                .buttonStyle(.borderedProminent)
                                            }
                                        }
                                    }
                        
                        Section {
                            Text("Budget: \(user.budget, specifier: "%.2f")").font(.title)
                        }
                    }
                    Section(header: Text("Transaction History")) {
                        ForEach(transactions) { transaction in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.player.name)
                                    Text(transaction.isPurchase ? "Bought" : "Sold")
                                        .font(.subheadline)
                                    Text("Price: \(transaction.player.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text(transaction.transactionDate, formatter: transactionDateFormatter)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
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


let transactionDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()


/*
// Preview
struct FantasyLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        FantasyLeagueView(viewModel: MockFantasyLeagueViewModel())
    }
}
*/
