//
//  MatchesScreen.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-28.
//

import SwiftUI

struct MatchesScreen: View {
    let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
    let footballModel = FootballModel()
    var Matches: [ChampionsLeagueData.MatchData.Match] {    
        footballModel.footballData?.matches.allMatches.filter { $0.status.finished || !$0.status.started  } ?? []
    }
    
    @State var MatchesisLoading = false
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            
            if MatchesisLoading {
                Color.black.opacity(1.0).edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            } else {
                VStack {
                    // Live Matches Section
                    
                    ScrollView(showsIndicators: false, content: {
                        MatchesSection
                    })
                  
                    
                    
                    Spacer()
                    
                    // Upcoming Matches Section
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(colorGreen))
                
                
                
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
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .padding([.leading, .trailing])
            }
        }
    }
}



#Preview {
    
    MatchesScreen()
}
