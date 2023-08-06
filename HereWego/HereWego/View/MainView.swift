//
//  MainView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/07/28.
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: Int = 0
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewMdoel: TeamAPIViewModel
    var body: some View {
        TabView(selection: $currentTab) {
            TeamListView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)
            
            TeamDetail(teamIndex: 0)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
