//
//  homeScreen.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-26.
//

import SwiftUI
import Foundation


struct tabScreen: View {
    var body: some View {
        TabView{
            homeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.circle.fill")
                }
            MatchesScreen()
                .tabItem {
                    Label("Matches" ,systemImage: "figure.soccer")
                }
            StandingsScreen()
                .tabItem {
                    Label("Standings" , systemImage: "soccerball")
                }
            StatsScreen()
                .tabItem {
                    Label("Stats", systemImage: "list.clipboard")
                }
        }
    }
    
}


struct homeScreen: View {
    let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
    let colorDark = UIColor(red: 0x39, green:0x47, blue: 0x38)
    let footballModel = FootballModel()
    
    @State var isLoading = false
    
    var upcomingMatches: [ChampionsLeagueData.MatchData.Match] {
            footballModel.footballData?.matches.allMatches.filter { !$0.status.started } ?? []
        }
    
    
    var body: some View {
            NavigationView {
                VStack {
                    // Use a ZStack to overlay the loading indicator on top of the current view
                    ZStack {
                        // if footballModel.isLoading
                        Color(colorGreen)
                                            .edgesIgnoringSafeArea(.all)
                        if isLoading {
                            Color.black.opacity(1.0).edgesIgnoringSafeArea(.all)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                        } else {
                            VStack {
                                // Live Matches Section
                                liveMatchesSection

                                Spacer()

                                // Upcoming Matches Section
                                upcomingMatchesSection
                            }
                    
                          
                        }
                    } 
                    .navigationTitle("Home")
                    .onAppear {
                        Task {
                            isLoading = true
                            await footballModel.loadfeed()
                            isLoading = false
                        }
                    }
                }
                
            }
        }
    
    // Extracted view for live matches to clean up the body
    var liveMatchesSection: some View {
        let liveMatches = footballModel.footballData?.matches.allMatches.filter { $0.status.started && !$0.status.finished } ?? []
        
        if liveMatches.isEmpty {
            return AnyView(Text("No live matches")
                            .font(.title)
                            .padding())
        } else {
            return AnyView(ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(liveMatches, id: \.id) { match in
                        MatchCardView(match: match)
                    }
                }
                .padding(50)
                .background(Color(colorDark).edgesIgnoringSafeArea(.all))
            })
        }
    }

        
        // Extracted view for upcoming matches to clean up the body
        var upcomingMatchesSection: some View {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                Text("Upcoming Matches").font(.headline).padding(.leading)
                ForEach(Array(upcomingMatches.prefix(4)), id: \.id) { match in
                    UpcomingMatchView(match: match)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
    
    /*
    var body: some View {
           NavigationView {
               VStack {
                   if footballModel.isLoading {
                       // Show loading indicator while data is being fetched
                       ProgressView()
                           .progressViewStyle(CircularProgressViewStyle(tint: .white))
                           .scaleEffect(1.5)
                   } else {
                       // Attempt to filter live matches
                       let liveMatches = footballModel.footballData?.matches.allMatches.filter { $0.status.started && !$0.status.finished } ?? []
                       
                       if liveMatches.isEmpty {
                           // Show "No live matches" if there are no live matches
                           Text("No live matches")
                               .font(.title)
                               .foregroundColor(.white)
                       } else {
                           // Display live matches if there are any
                           ScrollView(.horizontal, showsIndicators: false) {
                               HStack(spacing: 30) {
                                   ForEach(liveMatches) { match in
                                       MatchCardView(match: match)
                                   }
                               }
                               .padding(50)
                               .background(Color(colorDark))
                           }
                       }
                   }
                   Spacer()
                   VStack(spacing: 20) {
                       Text("Upcoming Matches")
                       ForEach(Array(upcomingMatches.prefix(6)), id: \.id) { match in
                           UpcomingMatchView(match: match)
                       }
                   }



               }
               .navigationTitle("Home")
               .background(Color(colorGreen))
               .foregroundColor(.white)
               .onAppear {
                   Task {
                       await footballModel.loadfeed()
                   }
               }
           }
       }
   }
     */



struct StandingsScreen: View {
    var body: some View {
       GroupStageView()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
            .navigationTitle("Standings")
    }
}

struct StatsScreen: View {
    @State var fantasyModel = FantasyModel()
    @State private var players: [PlayerFantasyStats] = []

    var body: some View {
        NavigationView {
            if players.isEmpty {
                Text("Loading...")
                    .onAppear {
                        loadFantasyData()
                    }
            } else {
                LeaderboardView(players: players)
                    .navigationTitle("Stats Screen")
            }
        }
    }
    
    func loadFantasyData() {
        // Assume loadAllData() now properly updates a fantasyData property
        // and getLeaderboard() is available to use.
        Task {
            await fantasyModel.loadAllData()
            // Now assuming fantasyModel can give us PlayerFantasyStats array
            // This could be a direct property or a method to transform fantasyData
            players = FantasyStatsProcessor.getLeaderboard() // Adjust based on your actual data handling
        }
    }
}



#Preview {
    tabScreen()
        
}
