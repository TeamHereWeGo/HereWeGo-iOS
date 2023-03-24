//
//  User.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import Foundation

struct User: Codable {
    var googleAPIData: GoogleAPIData?
    var userAPIData: JoinAPIData?
    
}

extension User {
    struct GoogleAPIData: Codable {
        let authProvider: String?
        let name: String?
        let email: String?
        let imageURL: String?
        let accessToken: String?
        let refreshToken: String?
        
        init(authProvider: String, name: String, email: String, imageURL: String, accessToken: String, refreshToken: String) {
            self.authProvider = authProvider
            self.name = name
            self.email = email
            self.imageURL = imageURL
            self.accessToken = accessToken
            self.refreshToken = refreshToken
        }
        
        
        
        //        mutating func setInfo(_ name: String, _ email: String, _ imageURL: String, _ accessToken: String, _ refreshToken: String) {
        //            self.name = name
        //            self.email = email
        //            self.imageURL = imageURL
        //            self.accessToken = accessToken
        //            self.refreshToken = refreshToken
        //        }
    }
    
    struct JoinAPIData: Codable {
        var jwtAccessToken: String?
        var jwtRefreshToken: String?
        var userId: String?
        
        init(_ joinAPIData: UserAPIViewModel.Responses.JoinAPIData) {
            jwtAccessToken = joinAPIData.jwtAccessToken
            jwtRefreshToken = joinAPIData.jwtRefreshToken
            userId = joinAPIData.userId
        }
        
        //        mutating func setInfo(_ serverSignInInfo: UserAPI.UserData) {
        //
        //        }
    }
    
    struct UserInfoAPIData: Codable {
        var email: String?
        var favorites: [String]?
        var gameUnit: [Int]?

        init(userInfoAPIData: UserAPIViewModel.Responses.UserInfoAPIData) {
            email = userInfoAPIData.email
            favorites = userInfoAPIData.favorites
            gameUnit = userInfoAPIData.gameUnit
        }

    }
    
    
}



