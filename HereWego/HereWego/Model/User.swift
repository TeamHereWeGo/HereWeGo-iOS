//
//  User.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/11.
//

import Foundation

struct User {
    private var email: String
    private var accessToken: String
    
    var favorites: [String]
    
}

extension User {
    struct HomeTeam {
        let teamName: String
        let league: String
        let icon: String
        let table: Int
    }

    struct Joining {
        private var leagueName: String
        private var icon: String
    }

    struct Statistics {
        private var goal: [Int]
        private var loss: [Int]
        private var shotsOnGoal: [Int]
        private var totalShots: [Int]
        private var blockedShots: [Int]
    }

}
