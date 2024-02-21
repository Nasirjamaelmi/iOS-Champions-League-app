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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
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
