//
//  championsleagueApp.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-19.
//

import SwiftUI
import Firebase
import SwiftData


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)-> Bool{
        FirebaseApp.configure()
        return true
    }
}

@main
struct championsleagueApp: App {
  
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
            //.modelContainer(for: PlayerFantasyStats.self )

        }
    }
}

