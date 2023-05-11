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
    @State private var searchText = ""
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    SearchView(searchText: $searchText)
                        .frame(height: 10)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        .cornerRadius(10)
                    Toggle(isOn: $showFavoriteOnly) {
                        Text("즐겨찾기")
                    }
                    // 즐겨찾기만 보기
                    if showFavoriteOnly {
                        if searchText == "" {
                            ForEach(userAPIViewModel.user.userInfoAPIData.favorites, id: \.teamName) { teamInfo in
                                if let teamIndex = userAPIViewModel.user.userInfoAPIData.favorites.firstIndex(where: { $0.teamName == teamInfo.teamName}) {
                                    NavigationLink {
                                        // optional 고쳐야 됨
                                        TeamDetail(teamIndex: teamIndex)
                                            .navigationBarTitleDisplayMode(.inline)
                                    } label: {
                                        // teamViewModel로 바꿔야됨
                                        TeamListRow(teamIndex: teamIndex)
                                    }
                                }
                            }
                        } else {    // 모두 보기
                            ForEach(userAPIViewModel.user.userInfoAPIData.favorites, id: \.teamName) { teamInfo in
                                if let teamIndex = userAPIViewModel.user.userInfoAPIData.favorites.firstIndex(where: { $0.teamName == teamInfo.teamName}) {
                                    if teamInfo.teamName.localizedCaseInsensitiveContains(searchText) {
                                        NavigationLink {
                                            // optional 고쳐야 됨
                                            TeamDetail(teamIndex: teamIndex)
                                                .navigationBarTitleDisplayMode(.inline)
                                        } label: {
                                            // teamViewModel로 바꿔야됨
                                            TeamListRow(teamIndex: teamIndex)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        if searchText == "" {
                            ForEach(teamAPIViewModel.team.teamList, id: \.teamId) { teamInfo in
                                if let teamIndex = teamAPIViewModel.team.teamList.firstIndex(where: { $0.teamId == teamInfo.teamId}) {
                                    NavigationLink {
                                        // optional 고쳐야 됨
                                        TeamDetail(teamIndex: teamIndex)
                                            .navigationBarTitleDisplayMode(.inline)
                                    } label: {
                                        // teamViewModel로 바꿔야됨
                                        TeamListRow(teamIndex: teamIndex)
                                    }
                                }
                            }
                        } else {
                            ForEach(teamAPIViewModel.team.teamList, id: \.teamId) { teamInfo in
                                if let teamIndex = teamAPIViewModel.team.teamList.firstIndex(where: { $0.teamId == teamInfo.teamId}) {
                                    if teamInfo.teamName.localizedCaseInsensitiveContains(searchText) {
                                        NavigationLink {
                                            // optional 고쳐야 됨
                                            TeamDetail(teamIndex: teamIndex)
                                                .navigationBarTitleDisplayMode(.inline)
                                        } label: {
                                            // teamViewModel로 바꿔야됨
                                            TeamListRow(teamIndex: teamIndex)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Button {
                        print("팀 리스트 로그 : \(teamAPIViewModel.team.teamList)")
                        print("팀 리스트 로그 1 : \(teamAPIViewModel.team.teamList[2])")
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
