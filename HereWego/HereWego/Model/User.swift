//
//  User.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import Foundation

struct User: Codable {
    var googleAPIData: GoogleAPIData?
    var joinAPIData: JoinAPIData?
    var userInfoAPIData: UserInfoAPIData?
    
}

extension User {
    struct GoogleAPIData: Codable {
        let authProvider: String
        let name: String
        let email: String
        let image: String
        let accessToken: String
        let refreshToken: String
        
        init(authProvider: String, name: String, email: String, image: String, accessToken: String, refreshToken: String) {
            self.authProvider = authProvider
            self.name = name
            self.email = email
            self.image = image
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
        let jwtAccessToken: String
        let jwtRefreshToken: String
        let userId: String
        
        init(jwtAccessToken: String, jwtRefreshToken: String, userId: String) {
            self.jwtAccessToken = "Bearer " + jwtAccessToken
            self.jwtRefreshToken = jwtRefreshToken
            self.userId = userId
        }
        
        //        mutating func setInfo(_ serverSignInInfo: UserAPI.UserData) {
        //
        //        }
    }
    
    struct UserInfoAPIData: Codable {
        let homeTeamId: Int
        let favorites: [User.UserInfoAPIData.TeamSummary]
        let gameUnit: [Int]
        
        
        init(homeTeamId: Int, favorites: [User.UserInfoAPIData.TeamSummary], gameUnit: [Int]) {
            self.homeTeamId = homeTeamId
            self.favorites = favorites
            self.gameUnit = gameUnit
        }
    }
    
}

extension User.UserInfoAPIData {
    struct TeamSummary: Codable {
        let teamName: String
        let league: String
        let icon: String
        let rank: Int
    }
}




