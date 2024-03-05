//
//  Fanstasyleaguedata.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

/*
import Foundation
import Observation


@Observable
class FantasyModel{
    
    var fantasyData: FanstasyleagueData?
    var isLoading = false
    
    
    func loadgoals() async {
        guard let url = URL(string:"https://data.fotmob.com/stats/42/season/20961/goals.json")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let fanstasy = try JSONDecoder().decode(FanstasyleagueData.self, from:data)
            fantasyData = fanstasy
            print(fanstasy)
            
        }
        catch{
            print(error)
        }
        isLoading = false
        
        
    }
    
    func loadfantasy(url: URL) async -> FanstasyleagueData? {
        isLoading = true
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let fanstasy = try JSONDecoder().decode(FanstasyleagueData.self, from:data)
            //fantasyData = fanstasy
            isLoading = false
            return fanstasy
        }
        catch{
            print(error)
        }
        isLoading = false
        return nil
        
        
    }
    
    
    
    
    
    func loadassist() async {
        guard let url = URL(string:"https://data.fotmob.com/stats/42/season/20961/goal_assist.json")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let fanstasy = try JSONDecoder().decode(FanstasyleagueData.self, from:data)
            fantasyData = fanstasy
            print(fanstasy)
            
        }
        catch{
            print(error)
        }
        isLoading = false
        
        
    }
    
    
    
    
    func loadcleansheets() async {
        guard let url = URL(string:"https://data.fotmob.com/stats/42/season/20961/clean_sheet.json")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let fanstasy = try JSONDecoder().decode(FanstasyleagueData.self, from:data)
            fantasyData = fanstasy
            print(fanstasy)
            
        }
        catch{
            print(error)
        }
        isLoading = false
        
        
    }
    
    
    func loadyellowcards() async {
        guard let url = URL(string:"https://data.fotmob.com/stats/42/season/20961/yellow_card.json")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let fanstasy = try JSONDecoder().decode(FanstasyleagueData.self, from:data)
            fantasyData = fanstasy
            print(fanstasy)
            
        }
        catch{
            print(error)
        }
        isLoading = false
        
        
    }
    
    
    
    func loadredcards() async {
        guard let url = URL(string:"https://data.fotmob.com/stats/42/season/20961/red_card.json")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let fanstasy = try JSONDecoder().decode(FanstasyleagueData.self, from:data)
            fantasyData = fanstasy
            print(fanstasy)
            
        }
        catch{
            print(error)
        }
        isLoading = false
        
        
    }
    
    
    
    
}

*/

import Foundation
import Observation

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
                // Log the raw data for debugging
                print(String(data: data, encoding: .utf8) ?? "No data to print")
                let fantasy = try JSONDecoder().decode(FanstasyleagueData.self, from: data)
                fantasyData.append(fantasy)
                print("Data loaded for \(statType.rawValue)")
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





