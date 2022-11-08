//
//  ProfileUser.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/07.
//

import SwiftUI

struct ProfileUser: View {
    @Binding var userName: String
    @Binding var password: String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("<회원 정보>")
            Text("ID : \(self.userName)")
            HStack {
                Text("PW : \(self.password)")
                Button {
                    
                } label: {
                    Text("[비밀번호 변경]")
                }
            }
            Text("휴대폰 : 010-9196-7601")
            
            Button {
                self.userName = ""
                self.password = ""
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
        ProfileUser(userName: .constant("jmtkd9196"), password: .constant("dlrudtn1234"))
    }
}
