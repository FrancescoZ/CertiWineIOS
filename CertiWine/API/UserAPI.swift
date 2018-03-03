//  User API
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

enum UserAPI{
  case getUser(withId: String)
  
  case updateUser(userId: String, email: String, passwrd: String, name: String)
  case createUser(email: String, name: String, passwrd: String, passwrdConfirmation: String)
  
  case login(email: String, passwd: String)
  
  case getStations(ofUserId: String)
  case createStation(ofUserId: String, name: String)
  
  case getSensors(ofUserId: String)
  case createSensor(ofUserId: String, name: String)
}

// MARK: - TargetType Protocol Implementation
extension UserAPI: TargetType {
  var baseURL: URL { return URL(string: Config.APIUrl)! }
  var path: String {
    switch self {
    case .getUser(let userId), .updateUser(let userId, _, _, _):
      return "/users/\(userId)"
    case .createUser(_, _, _, _):
      return "/users"
    case .login(_, _):
      return "/authenticate"
    case .getStations(let ofUserId), .createStation(let ofUserId, _):
      return "/\(ofUserId)/stations"
    case .getSensors(let ofUserId), .createSensor(let ofUserId, _):
        return "/\(ofUserId)/sensors"
    }
  }
  var method: Moya.Method {
    switch self {
    case .getUser, .getStations, .getSensors:
      return .get
    case .createUser, .updateUser, .createStation, .createSensor
      return .put
    case .login:
      return .post
    }
  }
  var task: Task {
    switch self {
    case .getUser, .getStations, .getSensors:
      return .requestPlain
    case let .updateUser(_, email, passwrd, name):
      return .requestParameters(parameters: ["email": email, "password": passwrd, "name": name],
        encoding: JSONEncoding.default)
    case let .createUser(email, name, passwrd, passwrdConfirmation):
      return .requestParameters(parameters: ["email": email, "password": passwrd, "name": name, "passwordConf": passwrdConfirmation], encoding: JSONEncoding.default)
    case let .login(email,passwrd):
      return .requestParameters(parameters: ["email": email, "password": passwrd],
        encoding: JSONEncoding.default)
    case let .createStation(_,name), .createSensor(_, name):
      return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
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


