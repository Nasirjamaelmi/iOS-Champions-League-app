//
//  ContentView.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-19.
//

import SwiftData
import SwiftUI
import Firebase
//https://chat.openai.com/share/7339ceff-624d-4c4e-8ffc-26ad20f2b658

struct ContentView: View {
    let modelContext: ModelContext
    @State var champ = FootballModel()
    @State var fan =  FantasyModel()
    
    var body: some View {
        VStack(alignment: .leading) {
             tabScreen(fantasyModel: fan, modelContext: modelContext)
        }
        
        //.task {
           // await champ.loadfeed()
            //await fan.loadfantasy()
        }
    }
    
//}

//#Preview {
//    ContentView()
//}
