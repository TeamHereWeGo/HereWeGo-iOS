//
//  UserAPI.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/01/05.
//

import SwiftUI

class UserAPI: ObservableObject {
    func fetch() {
        // 임시로 JSON 리다이렉트 url 직접 대입.(나중에 수정 예정)
        guard let url = URL(string: "http://hwgapp.com/v1/users?authorization=eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqbXRrZDkxOTZAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlzcyI6ImRlYnJhaW5zIiwiaWF0IjoxNjczMDc2MzIwLCJleHAiOjE2NzMwNzk5MjB9.MNSr3ubhmC4yuuggzNzSY3itBM_z_Dl0bLaLnE4pZtLEeuVQpTkfI9lcWNsLpTgwJjpf_1Xw-W6qhbm2OMej8A") else {
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
                    print(json)
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
