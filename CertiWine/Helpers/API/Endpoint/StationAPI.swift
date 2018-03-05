//  Station API
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
  enum StationAPI{
    case changeName(stationId: String, ofUserId: String, name: String)
    case getSensors(stationId: String, ofUserId: String)
    case pairSensor(stationId: String, ofUserId: String, sensorId: String)
    case getSensorsValues(stationId: String, ofUserId: String, sensorId: String)
  }
}

// MARK: - TargetType Protocol Implementation
extension API.StationAPI: TargetType {
  var baseURL: URL { return URL(string: Config.APIUrl)! }
  var path: String {
    switch self {
    case .getSensors(let stationId, let ofUserId):
      return "\(ofUserId)/stations/\(stationId)/sensors"
    case .changeName(let stationId, let ofUserId, _):
      return "\(ofUserId)/stations/\(stationId)"
    case .getSensorsValues(let stationId, let ofUserId, let sensorId), .pairSensor(let stationId, let ofUserId, let sensorId):
      return "\(ofUserId)/stations/\(stationId)/sensors/\(sensorId)"
    }
  }
  var method: Moya.Method {
    switch self {
    case .getSensors, .getSensorsValues:
      return .get
    case .changeName, .pairSensor:
      return .put
    }
  }
  var task: Task {
    switch self {
    case .getSensors, .getSensorsValues, .pairSensor:
      return .requestPlain
    case let .changeName(_, _, name):
      return .requestParameters(parameters: ["name": name],
                                encoding: JSONEncoding.default)
    }
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
  var sampleData: Data {
    switch self {
    default:
      return "data".utf8Encoded
    }
  }
}



