//
//  TeamTitle.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/05.
//

import SwiftUI

struct TeamTitle: View {
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
//    var teamImage: String
//    var teamName: String
//    var league: String
    var body: some View {
        HStack {
            Text("TEST")
//            Image(teamAPIViewModel.team.icon!)
//                .resizable()
//                .aspectRatio( contentMode: .fit)
//                .frame(width: 75, height: 75)
//            VStack {
//                HStack {
//                    Text(teamAPIViewModel.team.teamName!)
//                        .bold()
//                        .font(.title3)
//                        .lineLimit(1)
//                        .allowsTightening(true)
//                    Spacer()
//                }
//                HStack {
//                    Text(teamAPIViewModel.team.league!)
//                    Spacer()
//                    Button {
//
//                    } label: {
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                    }
//                    Button {
//
//                    } label: {
//                        Image(systemName: "house")
//                            .foregroundColor(.gray)
//                            .padding(.trailing)
//                    }
//
//                }
//            }
        }
    }
}

struct TeamTitle_Previews: PreviewProvider {
    static var previews: some View {
        TeamTitle()
            .environmentObject(TeamAPIViewModel())
    }
}
