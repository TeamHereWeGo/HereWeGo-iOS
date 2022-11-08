//
//  TeamListRow.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/02.
//

import SwiftUI

struct TeamListRow: View {
    var teamImage: String
    var teamName: String
    var rank: Int
    var body: some View {
        HStack {
            Image(teamImage)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 75, height: 75)
            VStack {
                HStack {
                    Text(teamName)
                        .bold()
                        .font(.title3)
                        .lineLimit(1)
                        .allowsTightening(true)
                    Spacer()
                }
                HStack {
                    Text("순위 : \(rank)위")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
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
    static var previews: some View {
        TeamListRow(teamImage: "Liverpool_logo", teamName: "Liverpool", rank: 9)
    }
}
