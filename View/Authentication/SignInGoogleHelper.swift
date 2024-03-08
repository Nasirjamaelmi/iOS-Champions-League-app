//
//  SignInGoogleHelper.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-08.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    
    let idToken : String
    let accessToken : String
}


final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel{
        
        guard let topVC = Utilites.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        
        guard  let idToken =  gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
     let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        
        return tokens
     
    }
}
