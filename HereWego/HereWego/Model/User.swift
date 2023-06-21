//
//  User.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import Foundation

struct User: Codable {
    var googleAPIData: GoogleAPIData
    var joinAPIData: JoinAPIData
    var userInfoAPIData: UserInfoAPIData
    
    init() {
        googleAPIData = GoogleAPIData()
        joinAPIData = JoinAPIData()
        userInfoAPIData = UserInfoAPIData()
    }
}

extension User {
    struct GoogleAPIData: Codable {
        var authProvider: String
        var name: String
        var email: String
        var image: String
        var accessToken: String
        var refreshToken: String
        
        init() {
            self.authProvider = ""
            self.name = ""
            self.email = ""
            self.image = ""
            self.accessToken = ""
            self.refreshToken = ""
        }
        
        init(authProvider: String, name: String, email: String, image: String, accessToken: String, refreshToken: String) {
            self.authProvider = authProvider
            self.name = name
            self.email = email
            self.image = image
            self.accessToken = accessToken
            self.refreshToken = refreshToken
        }
    }
    
    struct JoinAPIData: Codable {
        var jwtAccessToken: String
        var jwtRefreshToken: String
        var userId: String
        
        init() {
            self.jwtAccessToken = ""
            self.jwtRefreshToken = ""
            self.userId = ""
        }
        
        init(jwtAccessToken: String, jwtRefreshToken: String, userId: String) {
            self.jwtAccessToken = "Bearer " + jwtAccessToken
            self.jwtRefreshToken = jwtRefreshToken
            self.userId = userId
        }
    }
    
    struct UserInfoAPIData: Codable {
        var homeTeamId: Int
        var favorites: [User.UserInfoAPIData.TeamSummary]
        var gameUnit: [Int]
        
        init() {
            self.homeTeamId = 0
            self.favorites = []
            self.gameUnit = []
        }
        
        init(homeTeamId: Int, favorites: [User.UserInfoAPIData.TeamSummary], gameUnit: [Int]) {
            self.homeTeamId = homeTeamId
            self.favorites = favorites
            self.gameUnit = gameUnit
        }
    }
}

extension User.UserInfoAPIData {
    struct TeamSummary: Codable {
        var teamName: String
        var league: String
        var icon: String
        var rank: Int
    }
}
