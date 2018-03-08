//  Wine API
//  CertiWine
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 CertiWine.
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Moya


extension API {
  
  enum WineAPI{
    case getWine(withId: String, sensorId: String, userId: String, stationId: String)
    case getWines(userId: String, stationId: String)
    
    case createWine(name: String, year: Int, info: String, sensorId: String, userId: String, stationId: String)
    
    case getWineValues(stationId: String, ofUserId: String, sensorId: String, wineId: String)
  }
}

// MARK: - TargetType Protocol Implementation
extension API.WineAPI: TargetType {
  var baseURL: URL { return URL(string: Config.APIUrl)! }
  var path: String {
    switch self {
    case .getWineValues(let stationId,let ofUserId,let sensorId,let wineId):
        return "/\(ofUserId)/stations/\(stationId)/sensors/\(sensorId)/wines/\(wineId)"
    case .createWine(_,_,_,let sensorId, let userId, let stationId):
        return "/\(userId)/stations/\(stationId)/sensors/\(sensorId)/wines"
    case .getWine(let withId, let sensorId, let userId, let stationId):
        return "/\(userId)/stations/\(stationId)/sensors/\(sensorId)/wines\(withId)"
    case .getWines(let userId, let stationId):
      return "/\(userId)/stations/\(stationId)/sensors/wines"
    }
  }
  var method: Moya.Method {
    switch self {
    case .getWine, .getWines, .getWineValues:
      return .get
    case .createWine:
      return .put
    }
  }
  var task: Task {
    switch self {
    case .getWine, .getWines, .getWineValues:
      return .requestPlain
    case let .createWine(name, year, info,_,_,_):
      return .requestParameters(parameters: ["name": name, "info": info, "year": year],
                                encoding: JSONEncoding.default)
    }
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json",
            "x-access-token": Config.Auth ]
  }
  var sampleData: Data {
    switch self {
    default:
      return "data".utf8Encoded
    }
  }
}

