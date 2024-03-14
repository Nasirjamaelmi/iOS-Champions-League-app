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
        HStack {
            TeamLogoView(teamId: match.home.id)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(match.home.name)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            VStack {
                if let matchDate = match.status.utcTime.toDate() {
                    Text(matchDate, formatter: matchDateFormatter)
                        .fontWeight(.semibold)
                } else {
                    Text("TBA")
                        .fontWeight(.semibold)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(match.away.name)
                    .fontWeight(.semibold)
            }
            
            TeamLogoView(teamId: match.away.id)
        }
        .padding()
        .frame(width: 350, height: 80)
        .background(Color.green)
        .cornerRadius(12)
        .foregroundColor(.white)
    }

    var matchDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH.mm"
        return formatter
    }
}

//code provided by abdi from 58-82
struct TeamLogoView: View {
    let teamId: String?

    var body: some View {
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
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
        }
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
