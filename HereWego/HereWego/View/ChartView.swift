//
//  ChartView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/05/12.
//

import SwiftUI
import Charts

struct ChartView: View {
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var teamIndex: Int
    @Binding var dataType: String
//    private var xAxis: Int
    let ranges: [[String: Int]] = [["1D": 1], ["1W": 1], ["1M": 4], ["3M": 12], ["ALL": 38]]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ranges, id: \.self) { item in
//                    guard let key = item.keys.first,
//                          let value = item[key] {
                              Button {
                                  
                              } label: {
                                  Text("test")
                                  
                              }
                              
//                          } else {
//                              return EmptyView()
//                          }
                }
                
                
            }
            .frame(height: 30)
            Chart {
                // 이 부분 keyPath를 사용하면 코드 반복없이 수정 가능할 것으로 보임.
                if dataType == "goal" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.goal.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                }
                else if dataType == "loss" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.loss.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "cornerKicks" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.cornerKicks.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "offSide" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.offSide.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "save" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.save.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "ballPossession" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "totalPasses" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.totalPasses.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "passesAccurate" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.passesAccurate.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "shotsOnGoal" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.shotsOnGoal.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "shotsOffGoal" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.shotsOffGoal.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "blockedShots" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.blockedShots.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "shotsInsideBox" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.shotsInsideBox.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "shotsOutsideBox" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.shotsOutsideBox.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "fouls" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.fouls.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "yellow" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.yellow.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else if dataType == "red" {
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.red.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                } else { /* secure coding */
                    ForEach(Array(teamAPIViewModel.team.teamList[teamIndex].statistics.goal.enumerated()), id: \.offset) { index, data in
                        LineMark(x: .value("Round", index + 1),
                                 y: .value("data", data))
                    }
                }
            }
            .chartXScale(domain: 1 ... 38) // 이 부분에 변수를 넣으면 원하는 scale로 조정 가능
            .padding()
            .border(.black, width: 1)
            
        }
        
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(teamIndex: 0, dataType: .constant("goal"))
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
