//
//  GoogleAPIViewModel.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/12.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

class GoogleAPIViewModel: ObservableObject {
    @Published var message: String = "API 호출 중..."
    @StateObject var userAPIViewModel = UserAPIViewModel()
    //    @Published var user: User = .init(googleSignResponse: User.GoogleData(), serverSignResponse: User.HwgSignInInfo())
    @Published var user = User()
    @Published var isLogined = false
    
    
    //test
    // 연동을 시도 했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // 사용자 정보 가져오기
        if let userId = user.userID,                  // For client-side use only!
           let idToken = user.idToken, // Safe to send to the server
           let fullName = user.profile?.name,
           let givenName = user.profile?.givenName,
           let familyName = user.profile?.familyName,
           let email = user.profile?.email {
            
            print("Token : \(idToken)")
            print("User ID : \(userId)")
            print("User Email : \(email)")
            print("User Name : \((fullName))")
            
        } else {
            print("Error : User Data Not Found")
        }
    }
    
    // 구글 로그인 연동 해제했을때 불러오는 메소드
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }
    
    // 구글 로그인 값 받아오기
    func handleSignInButton() -> Void {
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController()) { signInResult, error in
            guard let result = signInResult else {
                
                // Inspect error
                return
            }
            print("Success Google!")
            
            
            guard let name = result.user.profile?.name else { return }
            guard let email = result.user.profile?.email else { return }
            guard let imageURL = result.user.profile?.imageURL(withDimension: 320)?.absoluteString else { return }
            guard let accessToken = result.user.idToken?.tokenString else { return }
            let refreshToken = result.user.refreshToken.tokenString
            
            let googleAPIData = Responses.GoogleAPIData(authProvider: "GOOGLE", name: name, email: email, imageURL: imageURL, accessToken: accessToken, refreshToken: refreshToken)
            
            
            self.user.googleAPIData = User.GoogleAPIData(googleAPIData)
            

            
            self.userAPIViewModel.request("POST", "GOOGLE", self.user) { (result, data) in
                DispatchQueue.main.async { [weak self] in
                    print(self?.message)
                    //                self.message = data as! String
                    self?.user.userAPIData = User.JoinAPIData(data as! UserAPIViewModel.Responses.JoinAPIData)
                    print(self?.user)
                    if result {
                        self?.message = "로그인 성공"
                        self?.isLogined = result
                    } else {
                        self?.message = "로그인 실패"
                    }
                    print(self?.message)
                }
            }
            
            
            // If sign in succeeded, display the app's main content View.
        }
    }
}

extension UIApplication {
    // Root Controller
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewController = window.windows.last?.rootViewController else { return .init() }
        
        return viewController
    }
}

extension GoogleAPIViewModel {
    struct Responses: Codable {
        struct GoogleAPIData {
            let authProvider: String
            let name: String
            let email: String
            let imageURL: String
            let accessToken: String
            let refreshToken: String
        }
    }
}
