//
//  LoginView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/01.
//

import SwiftUI

struct LoginView: View {
    @State var id: String = ""
    @State var pw: String = ""
    var body: some View {
        VStack {
            Spacer()
            Image("UCL_logo")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 200, height: 200)
            Spacer()
            TextField("ID", text: $id)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
                .padding(.horizontal, 20)
            TextField("PW", text: $pw)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
                .padding(.horizontal, 20)
            Button {
                
            } label: {
                Text("Login")
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
            }
            Spacer()
            
            Text("아이디/비밀번호 찾기")
            Text("회원가입")
            HStack {
                Text("Oauth 연동")
                Image(systemName: "checkmark.square")
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
