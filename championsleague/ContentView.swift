//
//  ContentView.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-19.
//

import SwiftUI

struct ContentView: View {
    @State var champ = FootballModel()
    var body: some View {
        VStack(alignment: .leading) {
             tabScreen() 
        }
        .padding()
        .task {
            await champ.loadfeed()
        }
    }
}

#Preview {
    ContentView()
}
