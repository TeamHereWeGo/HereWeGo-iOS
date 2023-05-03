//
//  ProfileUser.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/07.
//

import SwiftUI

struct ProfileUser: View {
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("<회원 정보>")
            Text("ID : \(userAPIViewModel.user.googleAPIData?.name ?? "nil")")
            HStack {
                Text("PW : ")
                Button {
                    
                } label: {
                    Text("[비밀번호 변경]")
                }
            }
            Text("email : \(userAPIViewModel.user.googleAPIData?.email ?? "nil")")
            
            //아직 로그아웃 미구현
            Button {
            } label: {
                Text("로그아웃")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfileUser_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUser()
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
