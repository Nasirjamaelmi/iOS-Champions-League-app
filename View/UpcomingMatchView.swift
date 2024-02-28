//
//  UpcomingMatchView.swift
//  championsleague
//
//  Created by Nasir Jama elmi on 2024-02-26.
//

import SwiftUI

struct UpcomingMatchView: View {
    let match: ChampionsLeagueData.MatchData.Match

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 300, height: 80)
                .foregroundStyle(.green)
            
            HStack {
                VStack(alignment: .center, spacing: 4) {
                    Text(match.home.name)
                    Text("vs")
                    Text(match.away.name)
                }
                
                Spacer()
                
    
                if let matchDate = match.status.utcTime.toDate() {
                    Text(matchDate, formatter: matchDateFormatter)
                        .fontWeight(.semibold)
                } else {
                    Text("Date TBA")
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .foregroundStyle(.white)
        }
    }


    var matchDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}


extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}


/*
#Preview {
    UpcomingMatchView(match: <#T##ChampionsLeagueData.MatchData.Match#>)
}
*/
