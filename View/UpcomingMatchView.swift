//
//  UpcomingMatchView.swift
//  championsleague
//
//  Created by Nasir Jama elmi on 2024-02-26.
//

import SwiftUI

struct UpcomingMatchView: View {
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 300, height: 80)
                .foregroundStyle(.green)
            
            HStack {
                Text( "Barca")
                
                Text( "2-2")
                
                Text("City")
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    UpcomingMatchView()
}
