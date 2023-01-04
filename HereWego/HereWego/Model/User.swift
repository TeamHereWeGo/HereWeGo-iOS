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
    private var homeTeam: HomeTeam
    var favorites: Favorites
    
}

extension User {
    struct HomeTeam {
        let teamName: String
        let league: String
        let icon: String
        let table: Int
        let joining: Joining
        let statistics: Statistics
        var gameUnit: [Int]
    }

    struct Joining {
        let leagueName: String
        let icon: String
    }

    struct Statistics {
        let goal: [Int]
        let loss: [Int]
        let shotsOnGoal: [Int]
        let totalShots: [Int]
        let blockedShots: [Int]
        let shotsInsideBox: [Int]
        let fouls: [Int]
        let cornerKicks: [Int]
        let offSide: [Int]
        let ballPossession: [Int]
        let yellow: [Int]
        let red: [Int]
        let save: [Int]
        let totalPasses: [Int]
        let passesAccurate: [Int]
    }
    
    struct Favorites {
        let teamName: String
        let league: String
        let icon: String
        let rank: Int
    }
}



