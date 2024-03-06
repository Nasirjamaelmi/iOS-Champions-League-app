//
//  AuthenticationView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-06.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var ShowSignInView:Bool
    
    var body: some View {
        VStack{
            
            NavigationLink{
                SignInEmailView(showSignView: $ShowSignInView)
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in")
    }
}


#Preview {
    NavigationStack{
        AuthenticationView(ShowSignInView: .constant(false))
    }
  
}
