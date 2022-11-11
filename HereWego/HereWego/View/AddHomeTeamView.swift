//
//  AddHomeTeamView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/01.
//

import SwiftUI

struct AddHomeTeamView: View {
    @State private var havingHomeTeam = false
    @State private var showingView = false
    @Binding var loginSuccessful: Bool
    @Binding var userName: String
    @Binding var password: String
    var body: some View {
        NavigationStack {
            if havingHomeTeam {
                TeamListView(loginSuccessful: self.$loginSuccessful, userName: self.$userName, password: self.$password)
            }
            else {
                VStack {
                    Image("UCL_logo")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 200, height: 200)
                    NavigationLink {
                        TeamListView(loginSuccessful: self.$loginSuccessful, userName: self.$userName, password: self.$password)
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
                ProfileButton(loginSuccessful: $loginSuccessful, userName: $userName, password: $password)
                
            }
        }
    }
}

struct AddHomeTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddHomeTeamView(loginSuccessful: .constant(false), userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
    }
}
