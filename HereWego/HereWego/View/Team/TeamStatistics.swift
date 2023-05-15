//
//  TeamStatisticsView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/05/15.
//

import SwiftUI

struct TeamStatisticsView: View {
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var teamIndex: Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        Text("\(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession[])")
//        ForEach(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession, id: \.self) { statistic in
//            Text("statistics : \(statistic)")
//        }
    }
}

struct TeamStatistics_Previews: PreviewProvider {
    static var previews: some View {
        TeamStatisticsView(teamIndex: 33)
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
