//
//  TeamDetail.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/05.
//

import SwiftUI

struct TeamDetail: View {
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var teamIndex: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TeamTitle(teamIndex: teamIndex)
                Menu {
                    Button {
                        
                    } label: {
                        Image("UCL_logo")
                        Text("유럽 챔피언스리그")
                    }
                    Button {
                        
                    } label: {
                        Image("EPL_logo")
                        Text("잉글랜드 프리미어리그")
                    }
                    Button {
                        
                    } label: {
                        Image("EFL_logo")
                        Text("카라바오 컵")
                    }
                } label: {
                    Image(systemName: "trophy.fill")
                        .font(.title)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            Divider()
                .frame(height: 2)
                .overlay(.black)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            ChartView(teamIndex: teamIndex)
            ForEach(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession, id: \.self) { statistic in
                Text("statistics : \(statistic)")
            }
//            Text("득점 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.goal[0])")
//            Text("실점 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.loss[0])")
//            Text("볼 점유율 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession[0])")
//            Text("막힌 슛 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.blockedShots[0])")
//            Text("코너킥 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.cornerKicks[0])")
//            Text("오프사이드 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.offSide[0])")
//            Text("패스정확도 : \(teamAPIViewModel.team.teamList[teamIndex].statistics.passesAccurate[0])")
            
            Spacer()
        }
        .onAppear {
            print("userAPIViewModel.user : \(userAPIViewModel.user)")
            teamAPIViewModel.getTeamDetail(method: "GET", userData: userAPIViewModel.user, teamId: teamAPIViewModel.team.teamList[teamIndex].teamId)
            print(teamIndex)
            print("teamDetail : \(teamAPIViewModel.team.teamList[teamIndex])")
        }
    }
}

//struct TeamDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamDetail(teamIndex: 0)
//            .environmentObject(TeamAPIViewModel())
//            .environmentObject(UserAPIViewModel())
//    }
//}
