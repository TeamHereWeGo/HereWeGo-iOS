//
//  AddHomeTeamView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/01.
//

import SwiftUI

struct AddHomeTeamView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("UCL_logo")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                NavigationLink {
                    TeamListView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("+")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                Text("홈 팀을 추가하세요.")
            }
        }
    }
}

struct AddHomeTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddHomeTeamView()
    }
}
