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
                .frame(width: 200, height: 120)
                .foregroundStyle(.green)
            
            HStack {

                Text(match?.home.name ?? "City")
                
                Text(match?.status.scoreStr ?? "-")
                 
                Text(match?.away.name ?? "Barca")

                //logo(for: match.home.id)
                
                VStack {
                   // Text(match.home.name)
                   // Text(match.status.scoreStr ?? "-")
                    //Text(match.away.name)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                //logo(for: match.away.id)

            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
        }
    }
    

}




extension MatchCardView {
    @ViewBuilder
    func logo(for teamId: String?) -> some View {
        if let teamId = teamId, let url = URL(string: "https://images.fotmob.com/image_resources/logo/teamlogo/\(teamId)_xsmall.png") {
            AsyncImage(url: url) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .shadow(radius: 2)
        } else {
            Image(systemName: "sportscourt")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
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
