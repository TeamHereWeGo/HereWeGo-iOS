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
    
    //    func SignInButtonHandler(authProvider: String) -> Void {
    //        if authProvider == "Google" {
    //            self.handleSignInButton()
    //        } else if authProvider == "Kakao" {
    //
    //        }
    //
    //    }
    
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
            guard let image = result.user.profile?.imageURL(withDimension: 320)?.absoluteString else { return }
            guard let accessToken = result.user.idToken?.tokenString else { return }
            let refreshToken = result.user.refreshToken.tokenString
            
            
            
            self.user.googleAPIData = User.GoogleAPIData(authProvider: "GOOGLE", name: name, email: email, image: image, accessToken: accessToken, refreshToken: refreshToken)
            
            //            self.request("join", "GOOGLE") { (result, data) in
            //                DispatchQueue.main.async { [weak self] in
            //                    print(self?.message)
            //
            //                    //                self.message = data as! String
            //
            //                    //                    self?.user.userAPIData = User.JoinAPIData(data as! UserAPIViewModel.Responses.JoinAPIData)
            //                    //                    print(self?.userAPIViewModel.user)
            //                    if result {
            //                        self?.message = "로그인 성공"
            //                        self?.isLogined = result
            //                        print(self?.message)
            //                        print(self?.isLogined)
            //                        print(self?.user)
            //                    } else {
            //                        self?.message = "로그인 실패"
            //                    }
            //                    print(self?.message)
            //
            //
            //                }
            //            }
            self.registerNewUserGoogle(authProvider: "GOOGLE") { (result, data) in
                DispatchQueue.main.async { [weak self] in
                    print(self?.message)
                    
                    //                self.message = data as! String
                    
                    //                    self?.user.userAPIData = User.JoinAPIData(data as! UserAPIViewModel.Responses.JoinAPIData)
                    //                    print(self?.userAPIViewModel.user)
                    if result {
                        self?.message = "로그인 성공"
                        self?.isLogined = result
                        print(self?.message)
                        print(self?.isLogined)
                        print(self?.user)
                    } else {
                        self?.message = "로그인 실패"
                    }
                    print(self?.message)
                    
                    
                    
                    self?.getUserInfo() { (result, data) in
                        if result {
                            self?.message = "불러오기 성공"
                            print(self?.message)
                            print(self?.user)
                        } else {
                            self?.message = "불러오기 실패"
                        }
                        print(self?.message)
                    }
                }
            }
            
            // If sign in succeeded, display the app's main content View.
            
        }
    }
    
    
    // Body가 없는 요청
    func getUserInfo(completionHandler: @escaping (Bool, Any) -> Void) {
        
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
        print("user jwtAccessToken[getUser] : \(self.user.joinAPIData?.jwtAccessToken)")
        print("user id[getUser] : \(self.user.joinAPIData?.userId)")
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
            
            
            let jsonStr = String(decoding: data, as: UTF8.self)
            print("log [ASDFSADFDSAFADSFADSF] : \(data)")
            print(jsonStr)
            
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("log : \(urlRequest)")
                print("Error: HTTP request failed3")
                return
            }
            guard let output = try? JSONDecoder().decode(Responses.StatusCode.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }
            
            //test
            //            let jsonStr = String(decoding: data, as: UTF8.self)
            //            print(data)
            //            print("@@@@@@@@@@@@@@@@@@@@")
            //            print(response.self)
            //            print("########################")
            //            print(jsonStr)
            //            print("%%%%%%%%%%%%%%%%%%%%%%%")
            //            print(userData)
            

            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(jsonStr.utf8), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed1")
                return
            }
            //            print(jsonStr)
            
            self.user.userInfoAPIData = User.UserInfoAPIData(homeTeamId: jsonDictionary["homeTeamId"] as! Int, favorites: jsonDictionary["favorites"] as! [User.UserInfoAPIData.TeamSummary], gameUnit: jsonDictionary["gameUnit"] as! [Int])
            //test
            
            
            
            
            completionHandler(true, output.result)
        }.resume()
    }
    
    // Body가 있는 요청
    
    // Header와 Body 파라미터 나눠서 작성하기(아직 안고침)
    //Post 방식의 User join func
    func registerNewUserGoogle(authProvider: String, completionHandler: @escaping (Bool, Any) -> Void) {
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
            completionHandler(true, "Complete")
            
        }.resume()
    }
    
    /* 메소드별 동작 분리 */
    func request(_ method: String, _ authProvider: String, completionHandler: @escaping (Bool, Any) -> Void) {
        if method == "join" {
            if authProvider == "GOOGLE" {
                registerNewUserGoogle(authProvider: authProvider) { (success, data) in
                    print("TSETESTSETEST")
                    self.getUserInfo() { (success, data) in
                        completionHandler(success, data)
                    }
                    completionHandler(success, data)
                }
                
                
                
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

extension UserAPIViewModel {
    struct Responses: Codable {
        struct JoinAPIData: Codable {
            let jwtAccessToken: String
            let jwtRefreshToken: String
            let userId: String
            
        }
        
        
        struct GoogleAPIData {
            let authProvider: String
            let name: String
            let email: String
            let imageURL: String
            let accessToken: String
            let refreshToken: String
        }
        
        
        // Codable을 통해 JSON 객체를 Dictionary 타입으로 만들 수 있게 되었다.
        struct StatusCode: Codable {
            let success: Bool
            let result: String
            let message: String
        }
        
        struct UserInfoAPIData: Codable {
            let email: String
            let favorites: [String]
            let gameUnit: [Int]
        }
    }
    
}
