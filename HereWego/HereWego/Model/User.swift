//
//  User.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/17.
//

import Foundation

struct User: Codable {
    var googleAPIData: GoogleAPIData?
    var userAPIData: UserAPIData?

}

extension User {
    struct GoogleAPIData: Codable {
        var authProvider: String?
        var name: String?
        var email: String?
        var imageURL: String?
        var accessToken: String?
        var refreshToken: String?
        
        init(_ googleAPIData: GoogleAPIViewModel.Responses.GoogleAPIData) {
            authProvider = googleAPIData.authProvider
            name = googleAPIData.name
            email = googleAPIData.email
            imageURL = googleAPIData.imageURL
            accessToken = googleAPIData.accessToken
            refreshToken = googleAPIData.refreshToken
        }
        
//        mutating func setInfo(_ name: String, _ email: String, _ imageURL: String, _ accessToken: String, _ refreshToken: String) {
//            self.name = name
//            self.email = email
//            self.imageURL = imageURL
//            self.accessToken = accessToken
//            self.refreshToken = refreshToken
//        }
    }
    
    struct UserAPIData: Codable {
        var jwtAccessToken: String?
        var jwtRefreshToken: String?
        var userId: String?

        init(_ userAPIData: UserAPIViewModel.Responses.UserAPIData) {
            jwtAccessToken = userAPIData.jwtAccessToken
            jwtRefreshToken = userAPIData.jwtRefreshToken
            userId = userAPIData.userId
        }
        
//        mutating func setInfo(_ serverSignInInfo: UserAPI.UserData) {
//
//        }
    }
    
   
}



