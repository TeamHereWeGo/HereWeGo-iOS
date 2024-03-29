//
//  LoginView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/01.
//

import SwiftUI

// 사용 X
struct LoginView: View {
    @State private var stack = NavigationPath()
    @State private var userName = ""
    @State private var password = ""
    @State private var isLogined = false
    @State private var showSignUp = false
    @State private var oauteChecked = false
//    private var tempLoginData: [String: String] = ["jmtkd9196": "dlrudtn1234", "jae961217": "jaeyeon1234", "sukrrard97": "hyeonseok1234", "rurusu0704": "junyoung1234"]
    
    var body: some View {
        NavigationStack(path: $stack) {
            VStack {
                Spacer()
                Image("UCL_logo")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 200, height: 200)
                Spacer()
                TextField("Username", text: $userName)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
//                Button {
//                    print(userName)
//                    tempLoginData.forEach { loginData in
//                        print(loginData)
//                        if userName == loginData.key && password == loginData.value {
//                            isLogined = true
//                        }
//                    }
//                } label: {
//                    Text("Login")
//                        .padding()
//                        .background(Color.gray)
//                        .cornerRadius(5.0)
//                        .padding(.horizontal, 20)
//                }
                .navigationDestination(isPresented: $isLogined) {
                    AddHomeTeamView(isLogined: self.$isLogined, userName: self.$userName, password: self.$password)
                }
                Spacer()
                Text("아이디/비밀번호 찾기")
                Button {
                    showSignUp.toggle()
                } label: {
                    Text("회원가입")
                }
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView(showsSignUp: $showSignUp)
                }
                HStack {
                    Text("Oauth 연동")
                    Button {
                        oauteChecked.toggle()
                    } label: {
                        OauthCheckBox(isChecked: $oauteChecked)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewDisplayName("iPad Pro (11-inch) (4th generation)")
    }
}
