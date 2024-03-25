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
    let container: ModelContainer
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        do {
            container = try ModelContainer(for: Client.self, Transaction.self)
        } catch {
            fatalError("Failed to create modelcontainer for model")
        }
        
        FirebaseApp.configure()
        
        
    }
    
    var body: some Scene {
        
        
        WindowGroup {
            ContentView(modelContext: container.mainContext)

        }
        .modelContainer(container)
    }
}

