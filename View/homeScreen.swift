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


    var body: some View {
        NavigationView {
            
                   VStack() {
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 30) {
                               ForEach(0..<10) { _ in
                                   MatchCardView(match: nil)
                               }
                               
                           }
                           .padding(50)
                           .background(Color(colorDark))
                       }
                       Spacer()
                       VStack(spacing: 20){
                           Text("Upcoming Matches")
                           ForEach(0..<3) { i in
                               UpcomingMatchView()
                           }
                            
                            
                               
                       }
                       

                       // Add more content here as needed

                   }
                   .navigationTitle("Home")
                   .background(Color(colorGreen))
                   .foregroundColor(.white)
             
               
               }
 
                
           }
}

struct MatchesScreen: View {
    var body: some View {
        Text("Matches Screen")
            .font(.title)
            .padding()
            .navigationTitle("Matches")
    }
}

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
