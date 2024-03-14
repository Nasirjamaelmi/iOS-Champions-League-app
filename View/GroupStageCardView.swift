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
                .font(.title)

            ForEach(Array(teams.enumerated()), id: \.1.name) { index, team in
                HStack {
                    Spacer(minLength: 10)
                    
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


/*
 #Preview {
     GroupStageCardView()
 }
 */
 
