//
//  TeamListRow.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/02.
//

import SwiftUI

struct TeamListRow: View {
    @State private var isChecked = false
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var teamId: Int
    var body: some View {
        HStack {
            if let teamIndex = teamAPIViewModel.team.teamList.firstIndex(where: { $0.teamId == teamId}) {
                AsyncImage(url: URL(string: teamAPIViewModel.team.teamList[teamIndex].icon)) { image in
                    image
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 75, height: 75)
                } placeholder: {
                    Image(systemName: "paperplane.circle.fill")
                }
                .padding(20)
                VStack {
                    HStack {
                        Text(teamAPIViewModel.team.teamList[teamIndex].teamName)
                            .bold()
                            .font(.title3)
                            .lineLimit(1)
                            .allowsTightening(true)
                        Spacer()
                    }
                    HStack {
                        Text("순위 : \(1)위")
                        Spacer()
                        Button {
                            
                        } label: {
                            FavoriteButton(isChecked: $isChecked)
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "house")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    }
                }
            }
        }
    }
}

struct TeamListRow_Previews: PreviewProvider {
    static var previews: some View {
        var teamInfo = Team.TeamInfo()
        TeamListRow(teamId: 40)
            .environmentObject(TeamAPIViewModel())
    }
}

