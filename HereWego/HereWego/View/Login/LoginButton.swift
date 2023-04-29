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
    // Test
//    var viewModel: UserAPI = UserAPI()
//    @StateObject var userAPIViewModel: UserAPIViewModel = .init()
//    @State var isLogined = false
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    
    
    let url = URL(string: "http://hwgapp.com/oauth2/authorize/google?redirect_uri=http://hwgapp.com/v1/users")
    var provider : String
    var body: some View {
        if userAPIViewModel.isLogined {
//            AsyncImage(url: URL(string: ( googleAPIViewModel.user.googleAPIData?.imageURL)!))
//            Text("\((googleAPIViewModel.user.googleAPIData?.name)!) is Logined")
//            Button {
//                googleAPIViewModel.isLogined.toggle()
//            } label: {
//                Text("Log out")
//            }
            TeamDetail(teamId: userAPIViewModel.user.userInfoAPIData?.homeTeamId ?? 0)
        } else {
            VStack {
                Image("UCL_logo")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 200, height: 200)

                GoogleSignInButton(action: userAPIViewModel.handleSignInButton)
       
            }//VStack
            .padding()
        }
        
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton(provider: "Google")
            .environmentObject(UserAPIViewModel())
    }
}
