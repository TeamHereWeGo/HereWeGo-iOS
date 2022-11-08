//
//  Team.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/03.
//

import Foundation

struct Team: Codable {
    var teamName: String
    var league: String
    var icon: String
    var table: String
    var joining: [String: String]
    var rank: [String]
    var score: [Int]
    var loss: [Int]
    var diff: [Int]
    var assist: [Int]
    var scorePerGame: [Int]
    var penalty: [Int]
    var freekick: [Int]
    var shootingPerGame: [Int]
    var counter: [Int]
    var point: [Int]
    var cross: [Int]
    var Accuracy: [Int]
    var chanceMaking: [Int]
    var possession: [Int]
    var four: [Int]
    var cleanSheet: [Int]
    var dribble: [Int]
    var shotOnTarget: [Int]
    var xG: [Double]
    var newsLink: [String]
    var resultCode: String
    
    
}
