//
//  Team.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/03.
//

import Foundation

struct Team: Codable {
    var teamList: [TeamInfo] = []
}

extension Team {
    struct TeamInfo: Codable, Identifiable {
        var teamId: Int
        var teamName: String
        var league: String
        var icon: String
        var joining: Joining
        var statistics: Statistics
        let id: String
        
        init() {
            self.teamId = 0
            self.teamName = ""
            self.league = ""
            self.icon = ""
            self.joining = Joining(leagueName: self.league, icon: self.icon)
            self.statistics = Statistics(goal: [], loss: [], shotsOnGoal: [], shotsOffGoal: [], blockedShots: [], shotsInsideBox: [], shotsOutsideBox: [], fouls: [], cornerKicks: [], offSide: [], ballPossession: [], yellow: [], red: [], save: [], totalPasses: [], passesAccurate: [])
            self.id = ""
        }
        
        init(teamId: Int, teamName: String, league: String, icon: String, id: String) {
            self.teamId = teamId
            self.teamName = teamName
            self.league = league
            self.icon = icon
            self.joining = Joining(leagueName: self.league, icon: self.icon)
            self.statistics = Statistics(goal: [], loss: [], shotsOnGoal: [], shotsOffGoal: [], blockedShots: [], shotsInsideBox: [], shotsOutsideBox: [], fouls: [], cornerKicks: [], offSide: [], ballPossession: [], yellow: [], red: [], save: [], totalPasses: [], passesAccurate: [])
            self.id = ""
        }
        
        init(teamId: Int, teamName: String, league: String, icon: String, joining: Team.TeamInfo.Joining, statistics: Team.TeamInfo.Statistics, id: String) {
            self.teamId = teamId
            self.teamName = teamName
            self.league = league
            self.icon = icon
            self.joining = joining
            self.statistics = statistics
            self.id = id
        }
    }
}

extension Team.TeamInfo {
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
