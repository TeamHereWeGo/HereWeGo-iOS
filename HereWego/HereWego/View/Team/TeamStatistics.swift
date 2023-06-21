//
//  TeamStatisticsView.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/05/15.
//

import SwiftUI

struct TeamStatisticsView: View {
    @EnvironmentObject var userAPIViewModel: UserAPIViewModel
    @EnvironmentObject var teamAPIViewModel: TeamAPIViewModel
    var teamIndex: Int
    @Binding var dataType: String
    let dataTypesFirstColumn: [String: String] = ["득점": "goal", "실점": "loss",  "코너킥": "cornerKicks",  "오프사이드": "offSide",  "세이브": "save",  "볼 점유율": "ballPossession",  "총 패스 횟수": "totalPasses",  "패스 정확도": "passesAccurate"]
    let dataTypesSecondColumn: [String: String] = ["유효 슈팅": "shotsOnGoal",  "빗나간 슈팅": "shotsOffGoal",  "막힌 슈팅": "blockedShots",  "박스 안에서의 슈팅": "shotsInsideBox",  "박스 바깥에서의 슈팅": "shotsOutsideBox",  "파울": "fouls",  "옐로우 카드": "yellow",  "레드 카드": "red"]
    
    var body: some View {
        //        Text("\(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession[])")
        //        ForEach(teamAPIViewModel.team.teamList[teamIndex].statistics.ballPossession, id: \.self) { statistic in
        //            Text("statistics : \(statistic)")
        
        VStack {
            HStack {
                // 첫 번째 열
                VStack(alignment: .leading) {
                    /*
                     득점 : goal
                     실점 : loss
                     코너킥 : cornerKicks
                     오프사이드 : offSide
                     세이브 : save
                     볼 점유율 : ballPossession
                     총 패스 횟수 : totalPasses
                     패스 정확도 : passesAccurate
                     */
                    ForEach(dataTypesFirstColumn.sorted(by: <), id: \.key) { key, value in
                        Button {
                            dataType = value
                        } label: {
                            Text("\(key)")
                        }
                    }
//                    Button {
//                        dataType = "goal"
//                    } label: {
//                        Text("득점")
//                    }
//                    Text("실점")
//                    Text("코너킥")
//                    Text("오프사이드")
//                    Text("세이브")
//                    Text("볼 점유율")
//                    Text("총 패스 횟수")
//                    Text("패스 정확도")
//
                    //                                ForEach(items.indices.filter { $0 % 2 == 0 }, id: \.self) { index in
                    //                                    Text(items[index])
                    //                                        .padding()
                    //                                }
                }
                
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.black)
                
                // 두 번째 열
                VStack(alignment: .leading) {
                    ForEach(dataTypesSecondColumn.sorted(by: <), id: \.key) { key, value in
                        Button {
                            dataType = value
                        } label: {
                            Text("\(key)")
                        }
                    }
//                    /*
//                     유효 슈팅 : shotsOnGoal
//                     빗나간 슈팅 : shotsOffGoal
//                     막힌 슈팅 : blockedShots
//                     박스 안에서의 슈팅 : shotsInsideBox
//                     박스 바깥에서의 슈팅 : shotsOutsideBox
//                     파울 : fouls
//                     옐로우 카드 : yellow
//                     레드 카드 : red
//                     */
//                    Text("유효 슈팅")
//                    Text("빗나간 슈팅")
//                    Text("막힌 슈팅")
//                    Text("박스 안에서의 슈팅")
//                    Text("박스 바깥에서의 슈팅")
//                    Text("파울")
//                    Text("옐로우 카드")
//                    Text("레드 카드")
                    //                                ForEach(items.indices.filter { $0 % 2 != 0 }, id: \.self) { index in
                    //                                    Text(items[index])
                    //                                        .padding()
                }
            }
        }
        //        }
        .onAppear {
            // log 확인
            print("teamAPIViewModel.team.teamList[\(teamIndex)] : \(teamAPIViewModel.team.teamList[teamIndex])")
        }
    }
}

//struct TeamStatistics_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamStatisticsView(teamIndex: 33)
//            .environmentObject(UserAPIViewModel())
//            .environmentObject(TeamAPIViewModel())
//    }
//}
