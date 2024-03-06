//
//  ContentView.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-19.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var champ = FootballModel()
    @State var fan =  FantasyModel()
    
    var body: some View {
        VStack(alignment: .leading) {
             tabScreen()
        }
        
        .task {
            await champ.loadfeed()
            //await fan.loadfantasy()
        }
    }
    
}

#Preview {
    ContentView()
}
