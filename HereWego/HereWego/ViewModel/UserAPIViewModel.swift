//
//  UserAPIViewModel.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

fileprivate enum HereWeGoAPI {
    static let scheme = "http"
    static let host = "hwgapp.com"
    
    enum Path: String {
        case join = "/v1/join"
        case users = "/v1/users"
        case favorites = "/v1/teams/favorites"
    }
}



class UserAPIViewModel: ObservableObject {
    @Published var user = User()
    @Published var message: String = "API 호출 중..."
    @Published var isLogined = false
    
    
    
    // MARK: 로그인
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        if let userId = user.userID,
           let idToken = user.idToken,
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
    
    // MARK: 구글 로그인 연동 해제
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }
    
    // MARK: 로그인 토큰 및 유저 정보 받아오기
    func handleSignInButton() -> Void {
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController()) { signInResult, error in
            guard let result = signInResult else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                print("Success Google!")
                guard let name = result.user.profile?.name else { return }
                guard let email = result.user.profile?.email else { return }
                guard let image = result.user.profile?.imageURL(withDimension: 320)?.absoluteString else { return }
                guard let accessToken = result.user.idToken?.tokenString else { return }
                let refreshToken = result.user.refreshToken.tokenString
                self?.user.googleAPIData = User.GoogleAPIData(authProvider: "GOOGLE", name: name, email: email, image: image, accessToken: accessToken, refreshToken: refreshToken)
                self?.registerNewUserGoogle(authProvider: "GOOGLE")
                print("User : \(self?.user)")
            }
            // If sign in succeeded, display the app's main content View.
        }
    }
    
    // MARK: User 정보 불러오기(Token -> User Information 순으로)
    func registerNewUserGoogle(authProvider: String) {
        guard let json = try? JSONEncoder().encode(self.user.googleAPIData) else { return }
        
        // 1. URL Components 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.join.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        
        // 2. URL Request 설정(Header)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(self.user.googleAPIData.accessToken as? String, forHTTPHeaderField: "Access-Token")
        urlRequest.setValue(self.user.googleAPIData.refreshToken as? String, forHTTPHeaderField: "Refresh-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = json
        
        // log 출력
        print("log : \(urlRequest)")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            print("log1 : \(data)")
            guard let response = response else {
                print("Error: response error")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(jsonStr.utf8), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed2")
                return
            }
            
            // 3. 받아서 Dictionary 형태의 데이터를 User 객체에 저장
            self.user.joinAPIData = User.JoinAPIData(jwtAccessToken: jsonDictionary["jwtRefreshToken"] as! String, jwtRefreshToken: jsonDictionary["jwtRefreshToken"] as! String, userId: jsonDictionary["userId"] as! String)
            
            // log 출력
            print("user jwtAccessToken[Register] : \(self.user.joinAPIData.jwtAccessToken)")
            print("user id[Register] : \(self.user.joinAPIData.userId)")
            
            self.getUserInfo()
        }.resume()
    }
    
    // MARK: User에 Favorite Team 추가 및 삭제
    func registerFavoriteTeamOrDeregisterFavoriteTeam(teamId: Int) {
        guard let json = try? JSONEncoder().encode(self.user.googleAPIData) else { return }
        
        // 1. URL Components 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.favorites.rawValue
        urlComponents.queryItems = [URLQueryItem(name: "teamId", value: "\(teamId)")]
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 2. URL Request 설정(Header)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue(self.user.joinAPIData.userId as? String, forHTTPHeaderField: "UserId")
        urlRequest.setValue(self.user.joinAPIData.jwtAccessToken as? String, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = json
        
        // log 출력
        print("log[registerFavoriteTeamOrDeregisterFavoriteTeam] : \(urlRequest)")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            print("log1 : \(data)")
            guard let response = response else {
                print("Error: response error")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(jsonStr.utf8), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // log
            print(jsonStr)
            print(self.user.userInfoAPIData.favorites)
            
        }.resume()
    }
    
    // MARK: User.UserInfoAPIData 정보 저장
    func getUserInfo() {
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.users.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        
        // log 출력
        print("user jwtAccessToken[getUserInfo] : \(self.user.joinAPIData.jwtAccessToken)")
        print("user id[getUserInfo] : \(self.user.joinAPIData.userId)")
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(self.user.joinAPIData.jwtAccessToken as? String, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.joinAPIData.userId as? String, forHTTPHeaderField: "UserId")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("log : \(urlRequest)")
                print("Error: HTTP request failed3")
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary1")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed1")
                return
            }
            
            // log
            print("User.UserInfoAPIData [JSON Dictionary] : \(jsonDictionary)")
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let userInfoAPIData = try decoder.decode(User.UserInfoAPIData.self, from: data)
                    self.user.userInfoAPIData = userInfoAPIData
                    
                    // log
                    print("디코드 한 userInfoAPIData : \(userInfoAPIData)")
                    print("user.userInfoAPIData : \(self.user.userInfoAPIData)")
                    print("전체 유저 정보 : \(self.user)")
                }
                catch{
                    print("Error in JSON parsing")
                }
            }
            self.isLogined = true
        }.resume()
    }
    
    // MARK: Favorite Team인지 아닌지 확인(True / False)
    func isFavorite(team: Team.TeamInfo) -> Bool {
        for teamInfo in self.user.userInfoAPIData.favorites {
            if teamInfo.teamName == team.teamName {
                return true
            }
        }
        return false
    }
      
//    // MARK: Register Favorite Team or DeRegister Favorite Team
//    func toggleFavoriteTeam() {
//
//    }
    
    // MARK: 메소드 별 동작 분리
    func request(_ method: String, _ authProvider: String) {
        if method == "join" {
            if authProvider == "GOOGLE" {
                registerNewUserGoogle(authProvider: authProvider)
            }
        } else if method == "getInfo" {
            
        }
    }
}

extension UIApplication {
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewController = window.windows.last?.rootViewController else { return .init() }
        return viewController
    }
}
