//
//  Fanstasyleaguedata.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//



import Foundation
import Observation
import SwiftData

@Observable
class FantasyModel{
    
    var fantasyData: [FanstasyleagueData] = []
    var isLoading = false
    
 
    enum StatType: String {
        case goals = "goals"
        case assists = "goal_assist"
        case cleanSheets = "clean_sheet"
        case yellowCards = "yellow_card"
        case redCards = "red_card"
    }
    
    // New method to load data based on the stat type
    func loadData(forStatTypes statTypes: [StatType]) async {
        isLoading = true
        
        for statType in statTypes {
            guard let url = URL(string: "https://data.fotmob.com/stats/42/season/20961/\(statType.rawValue).json") else {
                continue
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                print("Successfully fetched data for stat type: \(statType.rawValue)")
                let fantasy = try JSONDecoder().decode(FanstasyleagueData.self, from: data)
                fantasyData.append(fantasy)
                FantasyStatsProcessor.processStats(from: fantasy.TopLists)
               
            } catch {
                print("Failed to load data for \(statType.rawValue): \(error)")
            }
        }
        
        isLoading = false
    }
    
  
    func loadAllData() async {
        await loadData(forStatTypes: [.goals, .assists, .cleanSheets, .yellowCards, .redCards])
        
    }
}





