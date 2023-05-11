//
//  FavoriteButton.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/09.
//

import SwiftUI

struct FavoriteButton: View {
    var isChecked: Bool
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var body: some View {
        Button {
            
        } label: {
            Label("Toggle Oauth", systemImage: isChecked ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isChecked ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isChecked: true)
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
