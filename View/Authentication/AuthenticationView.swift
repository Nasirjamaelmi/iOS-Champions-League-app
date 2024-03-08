//
//  AuthenticationView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-06.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

 



@MainActor
final class AuthenticationViewModel: ObservableObject{
    
    func signInGoogle() async throws{
        
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
       
    }
    
    
}

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
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
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal))
            {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        ShowSignInView = false
                    }
                    catch {
                        print(error)
                    }
                }
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
