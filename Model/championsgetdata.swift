//
//  championsgetdata.swift
//  championsleague
//
//  Created by Zachery Arscott on 2024-02-19.
//

import Foundation
import Observation


@Observable
class FootballModel{
    
    var footballData: ChampionsLeagueData?
    var groupData: [Int:ChampionsLeagueData.TableData.TableDataContent.GroupTable] = [:]
    
    var isLoading = false
    
    
    func loadfeed() async {
        guard let url = URL(string:"https://www.fotmob.com/api/leagues?id=42&ccode3=SWE")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            //print(data)
            let football = try JSONDecoder().decode(ChampionsLeagueData.self, from:data)
            separateGroupData(football)
            footballData = football
          
            }
        catch{
            print(error)
        }
       isLoading = false
        
    }
    
    private func separateGroupData(_ data: ChampionsLeagueData) {
        var groups: [Int:ChampionsLeagueData.TableData.TableDataContent.GroupTable] = [:]
        
        guard let tables = data.table.first?.data.tables else {
            print("couldn't extract tables")
            return
        }
        
        for (index, group) in tables.enumerated() {
            groups[index] = group
        }
                
        groupData = groups
    }
    
}
    
