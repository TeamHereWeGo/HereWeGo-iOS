//
//  FavoriteButton.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct FavoriteButton: View {
    var teamIndex: Int
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var body: some View {
        Button {
            userAPIViewModel.registerFavoriteTeamOrDeregisterFavoriteTeam(teamId: teamAPIViewModel.team.teamList[teamIndex].teamId)
        } label: {
                Label("Toggle Oauth", systemImage: userAPIViewModel.isFavorite(team: teamAPIViewModel.team.teamList[teamIndex]) ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(true ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(teamIndex: 40)
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
