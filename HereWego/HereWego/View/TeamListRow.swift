//
//  TeamListRow.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/02.
//

import SwiftUI

struct TeamListRow: View {
    @State private var isChecked = false
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
//    var teamImage: String
//    var teamName: String
//    var rank: Int
    var body: some View {
        HStack {
            Image(teamAPIViewModel.team.icon!)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 75, height: 75)
            VStack {
                HStack {
                    Text(teamAPIViewModel.team.teamName!)
                        .bold()
                        .font(.title3)
                        .lineLimit(1)
                        .allowsTightening(true)
                    Spacer()
                }
                HStack {
                    Text("순위 : \(1)위")
                    Spacer()
                    Button {
                        
                    } label: {
                        FavoriteButton(isChecked: $isChecked)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "house")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                    
                }
            }
        }
    }
}

struct TeamListRow_Previews: PreviewProvider {
//    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    static var previews: some View {
        TeamListRow()
            .environmentObject(TeamAPIViewModel())
    }
}
