//
//  MatchCardView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-26.
//

import SwiftUI

struct MatchCardView: View {
    let match: ChampionsLeagueData.MatchData.Match?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 230, height: 120)
                .foregroundStyle(.green)
            
            HStack {
                TeamLogoView(teamId: match?.home.id)
                Text(match?.home.name ?? "City")
                
                Text(match?.status.scoreStr ?? "2-2")
                 
                Text(match?.away.name ?? "Barca")
                TeamLogoView(teamId: match?.away.id)
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
        }
    }
}





#Preview {

//#Preview {

    
//    let championsLeagueDetailsData = ChampionsLeagueData.LeagueDetails(id: 1, type: "Test Type", name: "Test name", selectedSeason: "2024/2025", latestSeason: "2024/2025", shortName: "Test short name", country: "Sweden")
//    
//    let championsLeagueData = ChampionsLeagueData(details: championsLeagueDetailsData, table: <#T##[ChampionsLeagueData.TableData]#>, matches: <#T##ChampionsLeagueData.MatchData#>)
//    
//
//    let championsLeagueTableDataContent = ChampionsLeagueData.TableData.TableDataContent(composite: <#T##Bool#>, ccode: <#T##String#>, leagueId: <#T##Int#>, pageUrl: <#T##String#>, leagueName: <#T##String#>, legend: <#T##[ChampionsLeagueData.TableData.TableDataContent.Legend]#>, tables: <#T##[ChampionsLeagueData.TableData.TableDataContent.GroupTable]#>)
//    
//    
//    
//    
//    let championsLeagueTableData = ChampionsLeagueData.TableData(data: championsLeagueTableDataContent)
//    
//    
//    let chmampionsLeagueMatchData = ChampionsLeagueData.MatchData(firstUnplayedMatch: <#T##ChampionsLeagueData.MatchData.FirstUnplayedMatch#>, allMatches: <#T##[ChampionsLeagueData.MatchData.Match]#>)
    MatchCardView(match: nil)
}
