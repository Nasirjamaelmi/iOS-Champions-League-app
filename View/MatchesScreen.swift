//
//  MatchesScreen.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-28.
//

import SwiftUI

struct MatchesScreen: View {
    let footballModel = FootballModel()
    var Matches: [ChampionsLeagueData.MatchData.Match] {
        footballModel.footballData?.matches.allMatches.filter { !$0.status.started } ?? []
    }
    
    @State var MatchesisLoading = false
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            if MatchesisLoading {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            } else {
                VStack {
                    // Live Matches Section
                    
                    ScrollView{
                        MatchesSection
                    }
                    
                 

                    Spacer()

                    // Upcoming Matches Section
                
                }
                .padding(50)
                
            }
            
        }
        .onAppear {
            Task {
                MatchesisLoading = true
                await footballModel.loadfeed()
                MatchesisLoading = false
            }
            
        }
    }
    
    
    var MatchesSection: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Matches").font(.headline).padding(.leading)
            ForEach(Matches, id: \.id) { match in
                       LeaugeCardView(match: match)
                      
                           .padding([.leading, .trailing])
            }
        }
    }
}



#Preview {
   
    MatchesScreen()
}
