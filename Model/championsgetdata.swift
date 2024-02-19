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
        guard let url = URL(string:
                                "https://www.fotmob.com/_next/data/4355/en/leagues/42/overview/champions-league.json?id=42&tab=overview&slug=champions-league"
                            
        )
        else {
            return
        }
        isLoading = true
        
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            print(data)
            let decodeData = try JSONDecoder().decode(ChampionsLeagueData.self, from: data)
            self.footballData = decodeData
            
            
        }
        catch{
            print(error)
        }
        isLoading = false
    }
}
    
