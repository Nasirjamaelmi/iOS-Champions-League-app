//
//  RootView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-06.
//

import SwiftUI

struct RootView: View {
    
    @State private var showsSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showsignInView: $showsSignInView)
            }
        }
        .onAppear{
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showsSignInView = authuser == nil
        }
        .fullScreenCover(isPresented: $showsSignInView){
            NavigationStack{
                AuthenticationView(ShowSignInView: $showsSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
