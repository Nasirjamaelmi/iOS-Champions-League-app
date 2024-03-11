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
            container = try ModelContainer(for: Usera.self, Transaction.self)
        } catch {
            fatalError("Failed to create modelcontainer for model")
        }
        
        FirebaseApp.configure()
        //let container = try! ModelContainer(for: Usera.self)
        
    }
    
    var body: some Scene {
        
        
        WindowGroup {
            ContentView(modelContext: container.mainContext)
                //.modelContainer(for: Player.self)

        }
        .modelContainer(container)
    }
}

