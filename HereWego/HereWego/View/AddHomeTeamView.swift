//
//  AddHomeTeamView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/01.
//

import SwiftUI

struct AddHomeTeamView: View {
    @State private var showingView = false
    @Binding var userName: String
    @Binding var password: String
    var body: some View {
        VStack {
            if showingView {
                TeamListView(userName: self.$userName, password: self.$password)
            } else {
                Image("UCL_logo")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 200, height: 200)

                Button {
                    showingView.toggle()
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
        AddHomeTeamView(userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
    }
}
