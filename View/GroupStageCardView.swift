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
            Text(formattedGroupName)
                .font(.title) // Adjust font and styling as needed

            ForEach(Array(teams.enumerated()), id: \.1.name) { index, team in
                HStack {
                    Spacer(minLength: 10)

                    // Statistics
                    
                    Group {
                        if index < 2 {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                        }
                        if index == 2 {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 10, height: 10)
                        }
                        if index == 3    {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                        }
                        TeamLogoView(teamId: team.idString)
                        StatisticView(title: "PL", value: "\(team.played)")
                        StatisticView(title: "W", value: "\(team.wins)")
                        StatisticView(title: "D", value: "\(team.draws)")
                        StatisticView(title: "L", value: "\(team.losses)")
                        StatisticView(title: "GD", value: "\(team.goalConDiff)")
                        StatisticView(title: "PTS", value: "\(team.pts)")
                    }

                    .font(.caption)
                }
                Divider()
            }
           
        }
    }

    var formattedGroupName: String {
            let components = groupName.components(separatedBy: ".")
            if components.count == 2 {
                return "Group \(components[1])"
            } else {
                return groupName
            }
        }
}
//provided by abdullahi 
struct StatisticView: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .padding(2)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .frame(minWidth: 50,alignment: .center)
    }
}
/*  HStack{
 Text("\(team.idx ?? 0)")
     .font(.caption2)
     .padding(.trailing, 3)

 HStack {
     
     logo(for: "\(team.id ?? 0 )")

     Text(team.shortName ?? "Team Name")
         .font(.caption)
         .fontWeight(.bold)
     
     Spacer(minLength: 10)
     
     // Statistics
     Group {
         StatisticView(title: "PL", value: "\(team.played ?? 0)")
         StatisticView(title: "W", value: "\(team.wins ?? 0)")
         StatisticView(title: "D", value: "\(team.draws ?? 0)")
         StatisticView(title: "L", value: "\(team.losses ?? 0)")
         StatisticView(title: "GD", value: "\(team.goalConDiff ?? 0)")
         StatisticView(title: "PTS", value: "\(team.pts ?? 0)")
     }
     .font(.caption2)
     
 }
 .padding(10)
 .background(rankColor(team.idx))
 .cornerRadius(8)
}}*/

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
