//
//  TeamTitle.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/05.
//

import SwiftUI

struct TeamTitle: View {
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    var teamId: Int
//    var teamImage: String
//    var teamName: String
//    var league: String
    var body: some View {
        
        HStack {
            if let teamIndex = teamAPIViewModel.team.teamList.firstIndex(where: { $0.teamId == teamId}) {
                Image(teamAPIViewModel.team.teamList[teamIndex].icon)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 75, height: 75)
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
                        Text(teamAPIViewModel.team.teamList[teamIndex].league)
                        Spacer()
                        Button {

                        } label: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
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

struct TeamTitle_Previews: PreviewProvider {
    static var previews: some View {
        TeamTitle(teamId: 33)
            .environmentObject(TeamAPIViewModel())
            .environmentObject(UserAPIViewModel())
    }
}
