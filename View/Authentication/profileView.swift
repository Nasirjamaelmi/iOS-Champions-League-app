//
//  profileView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-06.
//

import SwiftUI
import Firebase



struct profileView: View {
    var body: some View {
        NavigationStack {
            AuthenticationView(ShowSignInView: .constant(false))
        }
    }
}



#Preview {
    profileView()
}
