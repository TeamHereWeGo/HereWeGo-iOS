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
    var teamId: Int
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TeamTitle()
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
            
            if let test1 = userAPIViewModel.user.userInfoAPIData?.homeTeamId {
                Text("te1 : \(test1)")
            } else {
                Text("nil")
            }
            if let test2 = teamAPIViewModel.team.teamName {
                Text("te2 : \(test2)")
            } else {
                Text("nil")
            }
            Spacer()
        }
        .onAppear {
            print("userAPIViewModel.user : \(userAPIViewModel.user)")
            teamAPIViewModel.getTeamList(method: "GET", userData: userAPIViewModel.user)
        }
    }
}

struct TeamDetail_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetail(teamId: 40)
            .environmentObject(TeamAPIViewModel())
            .environmentObject(UserAPIViewModel())
//
//        TeamDetail(teamImage: "ManchesterUnited_logo", teamName: "ManchesterUnited", league: "잉글랜드 프리미어리그")
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
//            .previewDisplayName("iPad Pro (11-inch) (4th generation)")
//        TeamDetail(teamImage: "ManchesterUnited_logo", teamName: "ManchesterUnited", league: "잉글랜드 프리미어리그")
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
