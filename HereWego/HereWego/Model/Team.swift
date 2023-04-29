//
//  Team.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/03.
//

import Foundation

struct Team: Codable {
    var teamId: Int
    var teamName: String
    var league: String
    var icon: String
    var joining: Joining?
    var statistics: Statistics?
    
    init() {
        self.teamId = 0
        self.teamName = "-"
        self.league = "-"
        self.icon = "-"
    }
    
    init(teamId: Int, teamName: String, league: String, icon: String) {
        self.teamId = teamId
        self.teamName = teamName
        self.league = league
        self.icon = icon
    }
    
    init(teamId: Int, teamName: String, league: String, icon: String, joining: Team.Joining, statistics: Team.Statistics) {
        self.teamId = teamId
        self.teamName = teamName
        self.league = league
        self.icon = icon
        self.joining = joining
        self.statistics = statistics
    }
}


extension Team {
    struct Joining: Codable {
        var leagueName: String
        var icon: String
    }
    
    struct Statistics: Codable {
        var goal: [Int]
        var loss: [Int]
        var shotsOnGoal: [Int]
        var shotsOffGoal: [Int]
        var blockedShots: [Int]
        var shotsInsideBox: [Int]
        var shotsOutsideBox: [Int]
        var fouls: [Int]
        var cornerKicks: [Int]
        var offSide: [Int]
        var ballPossession: [Int]
        var yellow: [Int]
        var red: [Int]
        var save: [Int]
        var totalPasses: [Int]
        var passesAccurate: [Int]
        
    }
}
