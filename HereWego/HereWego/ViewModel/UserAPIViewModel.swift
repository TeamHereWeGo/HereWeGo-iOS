//
//  UserAPIViewModel.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import SwiftUI

fileprivate enum HereWeGoAPI {
    static let scheme = "http"
    static let host = "hwgapp.com"
    
    enum Path: String {
        case join = "/v1/join"
    }
    
}



class UserAPIViewModel: ObservableObject {
    @Published var googleAPIViewModel = GoogleAPIViewModel()
    
    
    // Body가 없는 요청
    func requestGet(completionHandler: @escaping (Bool, Any) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPI.scheme
        urlComponents.host = HereWeGoAPI.host
        urlComponents.path = HereWeGoAPI.Path.join.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        //        guard let url = URL(string: url) else {
        //            print("Error: cannot create URL")
        //            return
        //        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(Responses.StatusCode.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }
            
            completionHandler(true, output.result)
        }.resume()
    }
    
    // Body가 있는 요청
    
    // Header와 Body 파라미터 나눠서 작성하기(아직 안고침)
    func requestPost(method: String, authProvider: String, userData: User, completionHandler: @escaping (Bool, Any) -> Void) {
        
        // parameter(= body)에 설정할 자료들 data -> json으로 변환
        
        guard let json = try? JSONEncoder().encode(userData.googleAPIData) else { return }
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
        
        urlRequest.httpMethod = method
        urlRequest.setValue(userData.googleAPIData?.accessToken as? String, forHTTPHeaderField: "Access-Token")
        urlRequest.setValue(userData.googleAPIData?.refreshToken as? String, forHTTPHeaderField: "Refresh-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = json
        
        
        
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
            print(data)
            print("@@@@@@@@@@@@@@@@@@@@")
            print(response.self)
            print("########################")
            print(jsonStr)
            print("%%%%%%%%%%%%%%%%%%%%%%%")
            print(userData)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(jsonStr.utf8), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print(jsonStr)
//            guard let output = try? JSONDecoder().decode(Responses.StatusCode.self, from: data) else {
//                print("Error: JSON Data Parsing failed")
//                return
//            }
//            print("[output] : \(output)")
            
            // 3. GoogleAPIViewModel에서 userAPIViewModel에 호출한 지점에 completionHandler를 통해 결과 값을 넘겨주기 위해 Dictionary 형식으로 데이터 변경
            
            let userAPIData = Responses.UserAPIData(jwtAccessToken: jsonDictionary["jwtRefreshToken"] as! String, jwtRefreshToken: jsonDictionary["jwtRefreshToken"] as! String, userId: jsonDictionary["userId"] as! String)
            
            // 4. 함수가 모두 종료 시 실행되는 핸들러 -> GoogleAPIViewModel로 결과 값 리턴
            completionHandler(true, userAPIData)
            
        }.resume()
    }
    
    /* 메소드별 동작 분리 */
    func request(_ method: String, _ authProvider: String, _ userData: User, completionHandler: @escaping (Bool, Any) -> Void) {
        if method == "GET" {
            //            requestGet { (success, data) in
            //                completionHandler(success, data)
            //            }
        }
        else {
            requestPost(method: method, authProvider: authProvider, userData: userData) { (success, data) in
                completionHandler(success, data)
            }
        }
    }
    
}


extension UserAPIViewModel {
    struct Responses: Codable {
        struct UserAPIData: Codable {
            let jwtAccessToken: String
            let jwtRefreshToken: String
            let userId: String
            
        }
        // Codable을 통해 JSON 객체를 Dictionary 타입으로 만들 수 있게 되었다.
        struct StatusCode: Codable {
            let success: Bool
            let result: String
            let message: String
        }
    }
    
}
