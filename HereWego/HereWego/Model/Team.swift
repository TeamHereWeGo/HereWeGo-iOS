//
//  Team.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/03.
//

import Foundation

struct Team: Codable {
    var teamId: Int?
    var teamName: String?
    var league: String?
    var icon: String?
    var joining: Joining?
    var statistics: Statistics?
    
    init(_ teamListAPIData: TeamAPIViewModel.Responses.SummaryInfo) {
        teamId = teamListAPIData.teamId
        teamName = teamListAPIData.teamName
        league = teamListAPIData.league
        icon = teamListAPIData.icon
    }
    
    init(_ teamDetailAPIData: TeamAPIViewModel.Responses.TeamDetailData) {
        teamId = teamDetailAPIData.teamId
        teamName = teamDetailAPIData.teamName
        league = teamDetailAPIData.league
        icon = teamDetailAPIData.icon
        joining = teamDetailAPIData.joining
        statistics = teamDetailAPIData.statistics
    }
}


extension Team {
    struct Joining: Codable {
        var leagueName: String?
        var icon: String?
    }
    
    struct Statistics: Codable {
        var goal: [Int]?
        var loss: [Int]?
        var shotsOnGoal: [Int]?
        var shotsOffGoal: [Int]?
        var blockedShots: [Int]?
        var shotsInsideBox: [Int]?
        var shotsOutsideBox: [Int]?
        var fouls: [Int]?
        var cornerKicks: [Int]?
        var offSide: [Int]?
        var ballPossession: [Int]?
        var yellow: [Int]?
        var red: [Int]?
        var save: [Int]?
        var totalPasses: [Int]?
        var passesAccurate: [Int]?
        
    }
}
