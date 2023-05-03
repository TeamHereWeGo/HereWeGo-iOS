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
    }
    
}



class UserAPIViewModel: ObservableObject {
    //    @Published var googleAPIViewModel = GoogleAPIViewModel()
    @Published var user = User()
    @Published var message: String = "API 호출 중..."
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
    
    // Body가 있는 요청
    
    // Header와 Body 파라미터 나눠서 작성하기(아직 안고침)
    //Post 방식의 User join func
    func registerNewUserGoogle(authProvider: String) {
        // parameter(= body)에 설정할 자료들 data -> json으로 변환
        
        
        guard let json = try? JSONEncoder().encode(self.user.googleAPIData) else { return }
        // 결과 :: Optional("{\"name\":\"demnodey\",\"part\":\"development\"}")
        
        // 1. url Component 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.join.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        // 이 방식으로도 url을 생성 가능하다. -> 두 차이점이 무엇인지??
        // urlComponent는 url의 각 영역(scheme, host 등)을 따로 property로써 설정할 수 있지만
        // URL은 String 형태의 url을 URL자료형으로 타입 캐스팅 하는 것이다.
        //        guard let url = URL(string: url) else {
        //            print("Error: cannot create URL")
        //            return
        //        }
        
        
        // 2. url Request 설정 (Header같은 것 설정)
        var urlRequest = URLRequest(url: url)
        // Test Code
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(self.user.googleAPIData?.accessToken as? String, forHTTPHeaderField: "Access-Token")
        urlRequest.setValue(self.user.googleAPIData?.refreshToken as? String, forHTTPHeaderField: "Refresh-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = json
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
            //            guard let output = try? JSONDecoder().decode(Responses.StatusCode.self, from: data) else {
            //                print("Error: JSON Data Parsing failed")
            //                return
            //            }
            //            print("[output] : \(output)")
            
            // 3. GoogleAPIViewModel에서 userAPIViewModel에 호출한 지점에 completionHandler를 통해 결과 값을 넘겨주기 위해 Dictionary 형식으로 데이터 변경
            
            
            
            self.user.joinAPIData = User.JoinAPIData(jwtAccessToken: jsonDictionary["jwtRefreshToken"] as! String, jwtRefreshToken: jsonDictionary["jwtRefreshToken"] as! String, userId: jsonDictionary["userId"] as! String)
            
            print("user jwtAccessToken[Register] : \(self.user.joinAPIData?.jwtAccessToken)")
            print("user id[Register] : \(self.user.joinAPIData?.userId)")
            
            
            
            // 4. 함수가 모두 종료 시 실행되는 핸들러 -> GoogleAPIViewModel로 결과 값 리턴
            
            self.getUserInfo()
            
        }.resume()
        
    }
    
    
    // Body가 없는 요청
    func getUserInfo() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.users.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        //        guard let url = URL(string: url) else {
        //            print("Error: cannot create URL")
        //            return
        //        }
        
        
        // 2. url Request 설정 (Header같은 것 설정)
        var urlRequest = URLRequest(url: url)
        print("user jwtAccessToken[getUserInfo] : \(self.user.joinAPIData?.jwtAccessToken)")
        print("user id[getUserInfo] : \(self.user.joinAPIData?.userId)")
        // Test Code
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(self.user.joinAPIData?.jwtAccessToken as? String, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.joinAPIData?.userId as? String, forHTTPHeaderField: "UserId")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("urlRequest : \(urlRequest)")
        
        
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
            
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            print("data : \(data)")
            
            let jsonStr = String(decoding: data, as: UTF8.self)
            print("log [ASDFSADFDSAFADSFADSF] : \(data)")
            print(jsonStr)
            
            
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
            //            print(jsonStr)
            print("jsonDictionary: \(jsonDictionary)")
            let test = jsonDictionary["favorites"]
            print("Test log : \(type(of: test))")
            
            
            
            //Check that there are no errors and that data exists
            if error == nil && data != nil {
                
                //Parse JSON
                let decoder = JSONDecoder()
                
                do{
                    
                    let userInfoAPIData = try decoder.decode(User.UserInfoAPIData.self, from: data)
                    self.user.userInfoAPIData = userInfoAPIData
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
    
    
    
    /* 메소드별 동작 분리 */
    func request(_ method: String, _ authProvider: String) {
        if method == "join" {
            if authProvider == "GOOGLE" {
                registerNewUserGoogle(authProvider: authProvider)
                
                
                
            }
        } else if method == "getInfo" {
            //            requestGet { (success, data) in
            //                completionHandler(success, data)
            //            }
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
