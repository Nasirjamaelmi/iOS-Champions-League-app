//
//  homeScreen.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-26.
//

import SwiftUI
import Foundation

struct homeScreen: View {

    var body: some View {
      
        NavigationView {
                   VStack {
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 20) {
                               ForEach(0..<10) {
                                   Text("Item \($0)")
                                       .foregroundStyle(.white)
                                       .font(.largeTitle)
                                       .frame(width: 50, height: 50)
                                       .background(.red)
                               }
                           }
                       }
                       Spacer()
                      
                       Text("Welcome to Your App")
                           .font(.title)
                           .padding()

                       // Add more content here as needed

                       NavigationLink(destination: DetailScreen()) {
                           Text("Go to Detail Screen")
                               .foregroundColor(.blue)
                               .padding()
                        
                       }
                       TabView{
                           NavigationStack{
                               
                               DetailScreen()
                           }
                           .tabItem {
                               Label("profile", systemImage: "person.fill")
                           }
                           
                       }
                   }
                   .navigationTitle("Home")
               }
           }
}

struct DetailScreen: View {
    var body: some View {
        Text("Detail Screen")
            .font(.title)
            .padding()
            .navigationTitle("Detail")
    }
}


#Preview {
    homeScreen()
        
}
