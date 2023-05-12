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
    
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreria"]
    let datas: [Double] = [357,693,406,656,708,508,395,577,525,793,557,511,201,389,588]
    
    var body: some View {
        getLinePath(values: datas) // 이 부분 아래에서 구현
              .stroke(.green ,style: StrokeStyle(lineWidth: 2, lineJoin: .round))
              .rotationEffect(.degrees(180), anchor: .center) // 시계방향으로 180도 회전
              .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) // y축 대칭
    }
}

//func customizeChart(dataPoints: [String], values: [Double]) {
//    var dataEntries: [ChartDataEntry] = []
//
//          for i in 0..<dataPoints.count {
//            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
//            dataEntries.append(dataEntry)
//          }
//
//            let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
//          let lineChartData = LineChartData(dataSet: lineChartDataSet)
//          lineChartView.data = lineChartData
//        }
//
//}

var totalWidth = UIScreen.main.bounds.width
var totalHeight = 200.0

private func getLinePath(values: [Double]) -> Path {
  guard values.count > 1 else { return Path() }
  let offset = (values.max()! - values.min()!) / 2.0
  
  let step = CGPoint(
    x: totalWidth / CGFloat(values.count - 1),
    y: totalHeight / CGFloat(values.max()! - values.min()!)
  )
  var path = Path()
  let p1 = CGPoint(x: 0, y: step.y * (values[0] - offset))
  path.move(to: p1)
  
  for i in 1..<values.count {
    let p2 = CGPoint(x: step.x * CGFloat(i), y: step.y * (values[i] - offset))
    path.addLine(to: p2)
  }
  
  return path
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(teamIndex: 0)
            .environmentObject(UserAPIViewModel())
            .environmentObject(TeamAPIViewModel())
    }
}
