//
//  GroupStageCardView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-03-04.
//

import SwiftUI

struct GroupStageCardView: View {
    let groupName: String
    let teams: [ChampionsLeagueData.TableData.TableDataContent.GroupTable.Group.Team]
    var body: some View {
        VStack(spacing: 20) {
            Text(groupName)
            HStack{
                Text("Club")
                Text ("W")
                Text("D")
                Text ("L")
                Text("Points")
            }
            ForEach(teams, id: \.name) { team in
                HStack {
                    TeamLogoView(teamId: team.idString)
                    Text(team.name)
                    Text("\(team.wins)")
                    Text("\(team.draws)")
                    Text("\(team.losses)")
                    Text("\(team.pts)")
                }
                Divider()
            }

        }
    }
}

/*
#Preview {
    GroupStageCardView(groupName: "www", teams: [ChampionsLeagueData.TableData.TableDataContent.GroupTable.Group.Team()])
}
*/

/*import SwiftUI
 
 struct GroupStageCardView: View {
     //let groupName: String
     let groupName: String = "GroupA"
     //let teams: ChampionsLeagueData.TableData.TableDataContent.GroupTable.Group.Team
     let teams: ChampionsLeagueData.TableData.TableDataContent.GroupTable.Group.Team = ChampionsLeagueData.TableData.TableDataContent.GroupTable.Group.Team(name: "", shortName: "", id: 8633, pageUrl: "", played: 1, wins: 1, draws: 1, losses: 1, scoresStr: "aa", goalConDiff: 1, pts: 1, idx: 1)
     var body: some View {
         VStack(spacing: 20) {
             Text(groupName)
                 HStack {
                     TeamLogoView(teamId: teams.idString)
                     Text(teams.name)
                     Text("\(teams.losses)")
                 }
                 Divider()
         }
     }
 }


 #Preview {
     GroupStageCardView()
 }
 */
