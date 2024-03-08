//
//  SettingsView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-06.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    
    func loadAuthProviders() {
        if let providers =  try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
              
    }
    
    
    func signOut()  throws{
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
    
        try await AuthenticationManager.shared.resetPassword(email: email)

    }
    func updateEmail() async throws {
        let email = "hello123@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws{
        let password = "Hello123!"
        try await AuthenticationManager.shared.updatePassword(password: password)
        
    }
    
     
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showsignInView: Bool
    
    var body: some View {
        List {
            Button("Log out"){
                Task {
                    do {
                        try viewModel.signOut()
                        showsignInView = true
                    }
                    catch {
                        print(error)
                     
                        
                    }
                }
             
            }
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
            

        }
        .onAppear{
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showsignInView: .constant(false))
    }
   
}

extension SettingsView {
    
    private var emailSection : some View {
        Section {
            
            
            Button("Reset password"){
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("reset password")
                    }
                    catch {
                        print(error)
                        
                        
                    }
                }
                
            }
            Button("Update password"){
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("update password")
                    }
                    catch {
                        print(error)
                        
                        
                    }
                }
                
            }
            Button("Update email"){
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("update email")
                    }
                    catch {
                        print(error)
                        
                        
                    }
                }
                
            }
        } header: {
            Text("Email functions")
        }
        
    }
}
