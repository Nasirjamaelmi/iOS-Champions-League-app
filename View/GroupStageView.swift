//
//  GroupStageView.swift
//  championsleague
//
//  Created by Nasir Jama elmi on 2024-03-02.
//

import SwiftUI

struct GroupStageView: View {
    let model = FootballModel()
    var body: some View {
       
            VStack
            {
                ScrollView{
                    ForEach(model.groupData.sorted(by: {$0.key < $1.key}), id: \.key) { key, value in
                        VStack {
                            GroupStageCardView(groupName: value.leagueName, teams: value.table.all)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    }
            }
        }
     
            .onAppear{
                Task{
                    await model.loadfeed()
                }
            }
        
        
    }
}

extension GroupStageView {
    private func displayGroupData() {
        
    }
}



#Preview {
    GroupStageView()
}
