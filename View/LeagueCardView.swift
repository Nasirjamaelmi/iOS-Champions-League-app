//
//  LeagueCardView.swift
//  championsleague
//
//  Created by Nasir Jama Elmi on 2024-02-28.
//

import SwiftUI

import SwiftUI

struct LeaugeCardView: View {
    let match: ChampionsLeagueData.MatchData.Match
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.green)
            VStack {
                HStack{
                    if let matchDate = match.status.utcTime.toDate() {
                        Text(matchDate, formatter: matchDateFormatter)
                        Text(match.roundName)
                            .fontWeight(.semibold)
                    } else {
                        Text("TBA")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
                VStack{
                    HStack{
                        Text(match.home.name)
                        TeamLogoView(teamId: match.home.id)
                    }
                    Text(match.status.scoreStr ?? "-")
                    HStack{
                        Text(match.away.name)
                        TeamLogoView(teamId: match.away.id)
                    }
                }
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            
        }
    }
}


var matchDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy HH.mm"
    return formatter
}

extension String {
    func tDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}

/*
#Preview {
    LeaugeCardView(match: nil)
}
*/
