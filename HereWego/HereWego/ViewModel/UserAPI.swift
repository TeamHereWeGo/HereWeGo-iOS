//
//  UserAPI.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/01/05.
//

import SwiftUI

class UserAPI: ObservableObject {
    func fetch() {
        guard let url = URL(string: "http://hwgapp.com/oauth2/authorize/google?redirect_uri=http://hwgapp.com/v1/users") else {
            return
        }
        
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let dataJson = data {

                // JSON parsing(외우기)
                // JSON 직렬화 (받았는데 JSON이 아닐 수도 있기 때문에 try를 통해 받는다.
                // do - catch : 오류 코드 처리
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: [])
                    print("- DATA -")
                    print(data)
                } catch {
                    // code
                    // Test
                    print("- ERROR -")
                    print(error)
                }
                
            }
        }
        task.resume()
        
    }
}
