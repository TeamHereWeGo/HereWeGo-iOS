//
//  SignUpView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/08.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showSignUp: Bool
    @State private var userName = ""
    @State private var userNameEmptyCheck = true
    @State private var userNameDuplicationCheck = true
    @State private var password = ""
    @State private var passwordEmptyCheck = true
    @State private var passwordReEnter = ""
    @State private var passwordSameCheck = true
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var nameEmptyCheck = true
    @State private var validAllVariables = false
    @State private var notValidAllVariables = false
    
    var body: some View {
        NavigationStack {
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
                            if !userNameEmptyCheck {
                                Text("아이디를 입력하세요.")
                                    .foregroundColor(.red)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            }
                            else if !userNameDuplicationCheck {
                                Text("이미 사용중인 아이디입니다.")
                                    .foregroundColor(.red)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            } else {
                                Text(" ")
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
                                Text("비밀번호가 비어있습니다.")
                                    .foregroundColor(.red)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            } else {
                                Text(" ")
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            }
                        }
                        Group {
                            Text("비밀번호 확인")
                                .font(.title)
                                .fontWeight(.black)
                            TextField("다시 한 번 입력하세요.", text: $passwordReEnter)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(5.0)
                                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                            if !passwordSameCheck {
                                Text("비밀번호가 일치하지 않습니다.")
                                    .foregroundColor(.red)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            }
                            else {
                                Text(" ")
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
                            if !nameEmptyCheck {
                                Text("이름을 입력하세요.")
                                    .foregroundColor(.red)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            }
                            else {
                                Text(" ")
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            }
                        }
                        Button {
                            if (userName != "" && password != "" && passwordReEnter != "" && firstName != "" && lastName != "") && userNameEmptyCheck && userNameDuplicationCheck && passwordEmptyCheck && passwordSameCheck && nameEmptyCheck {
                                validAllVariables = true
                                notValidAllVariables = false
                                showSignUp = false
                            } else {
                                validAllVariables = false
                                notValidAllVariables = true
                            }
                        } label: {
                            Text("가입하기")
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(5.0)
                                .padding(EdgeInsets(top: 30, leading: 0, bottom: 15, trailing: 0))
                        }
                        .alert(isPresented: $notValidAllVariables) {
                            Alert(title: Text("Here We Go"),
                                  message: Text("빈칸을 모두 입력하세요."),
                                  dismissButton: .default(Text("Close")))
                        }
                    }
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUp: .constant(true))
    }
}
