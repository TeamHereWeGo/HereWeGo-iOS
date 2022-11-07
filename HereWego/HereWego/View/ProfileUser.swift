//
//  ProfileUser.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/07.
//

import SwiftUI

struct ProfileUser: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("<회원 정보>")
            Text("ID : jmtkd9196")
            HStack {
                Text("PW: *******")
                Button {
                    
                } label: {
                    Text("[비밀번호 변경]")
                }
            }
            Text("휴대폰 : 010-9196-7601")
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfileUser_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUser()
    }
}
