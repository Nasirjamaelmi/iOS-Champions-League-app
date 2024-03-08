//
//  SignInEmailView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-06.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found..")
            return
        }
   
       try await AuthenticationManager.shared.createUser(email: email, password: password)
         
        
    }
    
    
    func signin() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found..")
            return
        }
   
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
         
        
    }
}

struct SignInEmailView: View {
    
    @StateObject private var  viewModel = SignInEmailViewModel()
    @Binding var showSignView: Bool
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
          
            
            Button{
                Task{
                    do {
                        try await viewModel.signUp()
                        showSignView = false
                        return
                    } catch{
                        print(error)
                    }
                    do {
                        try await viewModel.signin()
                        showSignView = false
                        return
                    } catch{
                        print(error)
                    }
                        
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
           
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    SignInEmailView(showSignView: .constant(false))
}
