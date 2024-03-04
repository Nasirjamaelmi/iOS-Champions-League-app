//
//  Fanstasyleaguedata.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-28.
//

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




