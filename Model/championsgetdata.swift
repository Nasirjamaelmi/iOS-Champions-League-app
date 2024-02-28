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
    
    var isLoading = false
    
    
    func loadfeed() async {
        guard let url = URL(string:"https://www.fotmob.com/api/leagues?id=42&ccode3=SWE")
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let football = try JSONDecoder().decode(ChampionsLeagueData.self, from:data)
            footballData = football
          
            }
        catch{
            print(error)
        }
       isLoading = false
        
    }
    
}
    
