//
//  GroupStageView.swift
//  championsleague
//
//  Created by Nasir Jama elmi on 2024-03-02.
//

import SwiftUI

struct GroupStageView: View {
    let colorGreen = UIColor(red: 0xAE, green:0xC7, blue: 0xAD)
    let model = FootballModel()
    var body: some View {
        
        VStack
        {        HStack{
            Circle()
                .fill(Color.blue)
                .frame(width: 10, height: 10)
            Text("Qualified")
            Spacer()
            Circle()
                .fill(Color.orange)
                .frame(width: 10, height: 10)
            Text("Europa Leauge")
            Spacer()
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
            Text("Disqualifed")
        }
        .font(.system(size: 16))
            ScrollView(showsIndicators:false, content:{
                ForEach(model.groupData.sorted(by: {$0.key < $1.key}), id: \.key) { key, value in
                    VStack {
                        
                        GroupStageCardView(groupName: value.leagueName, teams: value.table.all)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                }
            })
            
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
