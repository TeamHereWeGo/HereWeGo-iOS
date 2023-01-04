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
    @Binding var isLogined: Bool
    @Binding var userName: String
    @Binding var password: String
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
                    NavigationLink {
                        TeamDetail(teamImage: "ManchesterUnited_logo", teamName: "Manchester United", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "ManchesterUnited_logo", teamName: "Manchester United", rank: 5)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "Liverpool_logo", teamName: "LiverPool", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "Liverpool_logo", teamName: "LiverPool", rank: 9)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "ManchesterCity_logo", teamName: "Manchester City", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "ManchesterCity_logo", teamName: "Manchester City", rank: 2)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "LeisterCity_logo", teamName: "Leister City", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "LeisterCity_logo", teamName: "Leister City", rank: 3)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "ManchesterUnited_logo", teamName: "Manchester United", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "ManchesterUnited_logo", teamName: "Manchester United", rank: 5)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "Liverpool_logo", teamName: "LiverPool", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "Liverpool_logo", teamName: "LiverPool", rank: 9)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "ManchesterCity_logo", teamName: "Manchester City", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "ManchesterCity_logo", teamName: "Manchester City", rank: 2)
                    }
                    NavigationLink {
                        TeamDetail(teamImage: "LeisterCity_logo", teamName: "Leister City", league: "잉글랜드 프리미어리그")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        TeamListRow(teamImage: "LeisterCity_logo", teamName: "Leister City", rank: 3)
                    }
                }
                .navigationTitle("Search")
                .toolbar {
                    ToolbarItem {
                        ProfileButton(isLogined: $isLogined, userName: $userName, password: $password)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView(isLogined: .constant(true), userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
        TeamListView(isLogined: .constant(true), userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewDisplayName("iPad Pro (11-inch) (4th generation)")
        TeamListView(isLogined: .constant(true), userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
