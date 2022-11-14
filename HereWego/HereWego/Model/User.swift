//
//  User.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/11.
//

import Foundation

struct User {
    private var accountId: String
    private var refreshToken: String
    private var accountToken: String
    var homeTeam: String
    var favorites: [String]
    
}
