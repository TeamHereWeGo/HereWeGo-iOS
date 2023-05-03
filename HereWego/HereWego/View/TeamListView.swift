//
//  TeamListView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/02.
//

import SwiftUI

struct TeamListView: View {
    @State private var showFavoriteOnly = false
    @State private var showingProfile = false
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    SearchView()
                        .frame(height: 10)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .cornerRadius(10)
                    Toggle(isOn: $showFavoriteOnly) {
                        Text("즐겨찾기")
                    }
                    ForEach(teamAPIViewModel.team.teamList) { teamInfo in
                        NavigationLink {
                            // optional 고쳐야 됨
                            TeamDetail(teamId: teamInfo.teamId)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            // teamViewModel로 바꿔야됨
                            TeamListRow(teamId: teamInfo.teamId)
                        }
                    }
                    Button {
                        print("팀 리스트 로그 : \(teamAPIViewModel.team.teamList)")
                        print("팀 리스트 로그 1 : \(teamAPIViewModel.team.teamList[0])")
                    } label: {
                        Text("log")
                    }
                }
                .navigationTitle("Search")
                .toolbar {
                    ToolbarItem {
                        ProfileButton()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            teamAPIViewModel.getTeamList(method: "GET", userData: userAPIViewModel.user)
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
