//
//  AddHomeTeamView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/01.
//

import SwiftUI

struct AddHomeTeamView: View {
    @State private var showingView = false
    @State private var hasHomeTeam = false
    @Binding var isLogined: Bool
    @Binding var userName: String
    @Binding var password: String
    var body: some View {
        NavigationStack {
            if hasHomeTeam {
                TeamListView()
            }
            else {
                VStack {
                    Image("UCL_logo")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 200, height: 200)
                    NavigationLink {
                        TeamListView()
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
        .toolbar {
            ToolbarItem {
                ProfileButton()
                
            }
        }
    }
}

struct AddHomeTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddHomeTeamView(isLogined: .constant(false), userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
    }
}
