//
//  homeScreen.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-26.
//

import SwiftUI
import Foundation



struct tabScreen: View {
    let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
    var body: some View {
        TabView{
            homeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.circle.fill")
                }
            RootView()
                .tabItem{
                    Label("Profile" , systemImage:"person.crop.circle.fill")
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
        .onAppear(){
            UITabBar.appearance().barTintColor = UIColor(Color(colorGreen))
            UITabBar.appearance().backgroundColor = UIColor(Color(colorGreen))
            
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
    
    
    
    
    
    struct StandingsScreen: View {
        let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
        var body: some View {
            GroupStageView()
                .background(Color(colorGreen))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .navigationTitle("Standings")
        }
    }
    
    struct StatsScreen: View {
        @State var fantasyModel = FantasyModel()
        @State var players: [PlayerFantasyStats] = []
        
        var body: some View {
            NavigationView {
                if players.isEmpty {
                    Text("Loading...")
                        .onAppear {
                            loadFantasyData()
                        }
                } else if players.count > 0 {
                    LeaderboardView(players: players)
                        .navigationTitle("Stats Screen")
                } else {
                    Text("No data available")
                }
            }
            
        }
        
        func loadFantasyData() {
            Task {
                await fantasyModel.loadAllData()
                self.players = FantasyStatsProcessor.getLeaderboard()
                print("players fetched: \(players.count)")
                
            }
        }
    }}



#Preview {
    tabScreen()
    
}
