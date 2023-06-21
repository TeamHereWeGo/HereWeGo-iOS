//
//  TeamAPIViewModel.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2023/03/22.
//

import SwiftUI

import SwiftUI

fileprivate enum HereWeGoAPITeamList {
    static let scheme = "http"
    static let host = "hwgapp.com"
    
    enum Path: String {
        case teams = "/v1/teams"
    }
}

class TeamAPIViewModel: ObservableObject {
    @Published var team = Team()
    @Published var message: String = "API 호출 중..."
    
    // MARK: 팀 리스트 불러오기
    func getTeamList(method: String, userData: User) {
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPITeamList.scheme
        urlComponents.host = HereWeGoAPITeamList.host
        urlComponents.path = HereWeGoAPITeamList.Path.teams.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(userData.joinAPIData.userId as? String, forHTTPHeaderField: "UserId")
        request.setValue(userData.joinAPIData.jwtAccessToken as? String, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response else {
                print("Error: response error")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [[String: Any]] else {
                print("Error: convert failed json to dictionary111")
                return
            }
            
            // log
            print("TeamAPIViewModel [jsonDictionary] : \(jsonDictionary)")
            print("type : \(type(of: jsonDictionary))")
            
            DispatchQueue.main.async { [weak self] in
                if let array = jsonDictionary as? [[String: Any]] {
                    for dict in array {
                        if let teamName = dict["teamName"] as? String,
                           let teamId = dict["teamId"] as? Int,
                           let icon = dict["icon"] as? String,
                           let league = dict["league"] as? String {
                            let team = Team.TeamInfo(teamId: teamId, teamName: teamName, league: league, icon: icon, id: UUID().uuidString)
                            self?.team.teamList.append(team)
                        }
                    }
                }
                
                // log
                print("TeamAPIViewModel.team : \(self?.team)")
            }
        }.resume()
    }
    
    // MARK: 팀 데이터 불러오기
    func getTeamDetail(method: String, userData: User, teamId: Int) {
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPITeamList.scheme
        urlComponents.host = HereWeGoAPITeamList.host
        urlComponents.path = HereWeGoAPITeamList.Path.teams.rawValue + "/" + String(teamId)
        print(urlComponents)
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(userData.joinAPIData.userId as? String, forHTTPHeaderField: "UserId")
        request.setValue(userData.joinAPIData.jwtAccessToken as? String, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response else {
                print("Error: response error")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            
            //log
            print(jsonStr)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            
            // log
            print("TeamAPIViewModel [jsonDictionary] : \(jsonDictionary["statistics"])")
            print("type : \(type(of: jsonDictionary))")
            
            DispatchQueue.main.async { [weak self] in
                print("testLog")
                //                  statistics 구현해야 됨
                if let statisticsArray = jsonDictionary["statistics"] as? [String: Any] {
                    if let goal = statisticsArray["goal"] as? [Int],
                       let loss = statisticsArray["loss"] as? [Int],
                       let shotsOnGoal = statisticsArray["shotsOnGoal"] as? [Int],
                       let shotsOffGoal = statisticsArray["shotsOffGoal"] as? [Int],
                       let totalShots = statisticsArray["totalShots"] as? [Int],
                       let blockedShots = statisticsArray["blockedShots"] as? [Int],
                       let shotsInsideBox = statisticsArray["shotsInsideBox"] as? [Int],
                       let shotsOutsideBox = statisticsArray["shotsOutsideBox"] as? [Int],
                       let fouls = statisticsArray["fouls"] as? [Int],
                       let cornerKicks = statisticsArray["cornerKicks"] as? [Int],
                       let offSide = statisticsArray["offSide"] as? [Int],
                       let ballPossession = statisticsArray["ballPossession"] as? [Int],
                       let yellow = statisticsArray["yellow"] as? [Int],
                       let red = statisticsArray["red"] as? [Int],
                       let save = statisticsArray["save"] as? [Int],
                       let totalPasses = statisticsArray["totalPasses"] as? [Int],
                       let passesAccurate = statisticsArray["passesAccurate"] as? [Int] {
                        if let index = self?.team.teamList.firstIndex(where: { $0.teamId == teamId}) {
                            print(index)
                            self?.team.teamList[index].statistics = Team.TeamInfo.Statistics(goal: goal, loss: loss, shotsOnGoal: shotsOnGoal, shotsOffGoal: shotsOffGoal, blockedShots: blockedShots, shotsInsideBox: shotsInsideBox, shotsOutsideBox: shotsOutsideBox, fouls: fouls, cornerKicks: cornerKicks, offSide: offSide, ballPossession: ballPossession, yellow: yellow, red: red, save: save, totalPasses: totalPasses, passesAccurate: passesAccurate)
                            print(self?.team.teamList[index])
                        } else {
                            print("error1")
                        }
                        
                    } else {
                        print("error2")
                    }
                }
                
                
//                //  joining 파싱 구현
//                if let joiningArray = jsonDictionary["joining"] as? [Any],
//                   let joiningObject = joiningArray.first as? [String: Any] {
//                    print("testLog")
//                    if let icon = joiningObject["icon"] as? String,
//                       let leagueName = joiningObject["leagueName"] as? String {
//                        print("icon: \(icon), leagueName: \(leagueName)")
//                    } else {
//
//                    }
//                } else {
//                    print("Failed to parse joining data")
//                }
                
                
                // log
                print("TeamAPIViewModel.team : \(self?.team)")
            }
        }.resume()
    }
    
    // MARK: 미구현
    func requestPost(method: String, authProvider: String, userData: User, completionHandler: @escaping (Bool, Any) -> Void) {
        guard let json = try? JSONEncoder().encode(userData.googleAPIData) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = HereWeGoAPITeamList.scheme
        urlComponents.host = HereWeGoAPITeamList.host
        urlComponents.path = HereWeGoAPITeamList.Path.teams.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue(userData.googleAPIData.accessToken as? String, forHTTPHeaderField: "Access-Token")
        urlRequest.setValue(userData.googleAPIData.refreshToken as? String, forHTTPHeaderField: "Refresh-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = json
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response else {
                print("Error: response error")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            let jsonStr = String(decoding: data, as: UTF8.self)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(jsonStr.utf8), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
        }.resume()
    }
    
    // MARK: 메소드 별 동작 분리
    func request(_ method: String, _ userData: User) {
        if method == "GET" {
            getTeamList(method: method, userData: userData)
        }
        else {
            
        }
    }
}
