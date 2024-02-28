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
                        if isLoading {
                            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
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
                            .background(Color(colorGreen).edgesIgnoringSafeArea(.all))
                            .foregroundColor(Color(colorDark))
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
        Text("Standings Screen")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
            .navigationTitle("Standings")
    }
}

struct StatsScreen: View {
    var body: some View {
        Text("Stats Screen")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
            .navigationTitle("Stats Screen")
    }
}


#Preview {
    tabScreen()
        
}
