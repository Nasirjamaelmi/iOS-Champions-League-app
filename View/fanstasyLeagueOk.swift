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
    
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Available Players")) {
                    ForEach(viewModel.availablePlayers) { player in
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
                
                
                
                if let user = viewModel.user {
                    Section(header: Text("Your Roster")) {
                        ForEach(transactions.filter { $0.isPurchase }, id: \.player.id) { transaction in
                            HStack{
                                Text(transaction.player.name)
                                Spacer()
                                Button("Sell"){
                                    viewModel.sellPlayer(player: transaction.player)
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
            .navigationTitle("Fantasy League")
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
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
