//
//  LoginButton.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/12/23.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginButton: View {
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    @State private var isLoggedIn: Bool = false
    
    let url = URL(string: "http://hwgapp.com/oauth2/authorize/google?redirect_uri=http://hwgapp.com/v1/users")
    var provider : String
    var body: some View {
        NavigationStack {
            VStack {
                Image("UCL_logo")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 200, height: 200)
                GoogleSignInButton(action: userAPIViewModel.handleSignInButton)
            }
            .padding()
            
            .navigationDestination(isPresented: $userAPIViewModel.isLogined) {
                MainView()
            }
        }
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton(provider: "Google")
            .environmentObject(UserAPIViewModel())
    }
}
