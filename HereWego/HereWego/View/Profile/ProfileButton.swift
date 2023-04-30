//
//  ProfileButton.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct ProfileButton: View {
    @State private var showingProfile = false
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    
    var body: some View {
        Button {
            showingProfile.toggle()
        } label: {
            Label("User Profile", systemImage: "person.crop.circle")
                .foregroundColor(.black)
                .labelStyle(.iconOnly)
        }
        .sheet(isPresented: $showingProfile) {
            ProfileUser()
        }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton()
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
