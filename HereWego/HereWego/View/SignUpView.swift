//
//  SignUpView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/08.
//

import SwiftUI

struct SignUpView: View {
    @State private var userName = ""
    @State private var userNameDuplicationCheck = false
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var passwordEmptyCheck = false
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        VStack {
            Image("UCL_logo")
            ScrollView {
                
                VStack {
                    Group {
                        Text("아이디")
                            .font(.title)
                            .fontWeight(.black)
                        TextField("아이디를 입력하세요.", text: $userName)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(5.0)
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                        if !userNameDuplicationCheck {
                            Text("이미 사용중인 아이디입니다.")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        }
                    }
                    Group {
                        Text("비밀번호")
                            .font(.title)
                            .fontWeight(.black)
                        TextField("비밀번호를 입력하세요.", text: $password)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(5.0)
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                        if !passwordEmptyCheck {
                            Text("비밀번호가 비어있습니다. 다시 입력하세요.")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        }
                    }
                    Group {
                        Text("비밀번호 확인")
                            .font(.title)
                            .fontWeight(.black)
                        TextField("다시 한 번 입력하세요.", text: $passwordConfirm)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(5.0)
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                        if password == passwordConfirm {
                            Text("비밀번호가 일치하지 않습니다.")
                                .foregroundColor(.red)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        }
                    }
                    Group {
                        Text("이름")
                            .font(.title)
                            .fontWeight(.black)
                        HStack {
                            TextField("성", text: $lastName)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(5.0)
                                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 5))
                            TextField("이름", text: $firstName)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(5.0)
                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing:50))
                        }
                    }
                    Button {
                        
                    } label: {
                        Text("가입하기")
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(5.0)
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 15, trailing: 0))
                    }
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
