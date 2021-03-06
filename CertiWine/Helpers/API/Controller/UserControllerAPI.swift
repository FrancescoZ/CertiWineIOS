//  User Controller API
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

extension API{
  static func getUser(withId:String,
                      onSuccess success: @escaping (_ response: Any) -> Void,
                      onFailure failure: @escaping (_ error: Error) -> Void){
    API.userProvider.request(.getUser(withId: withId)) { result in
          handleResponse(result: result, to: User.self, onSuccess: success, onFailure: failure)
        }
    }
  
  static func getStations(ofUserId: String,
                          onSuccess success: @escaping (_ response: Any) -> Void,
                          onFailure failure: @escaping (_ error: Error) -> Void){
    API.userProvider.request(.getStations(ofUserId: ofUserId)) { result in
      handleResponse(result: result, to: [Station].self, onSuccess: success, onFailure: failure)
    }
  }
  
  static func updateAlerts(userId: String,
                            vib: Float,
                            hum: Float,
                            temp: Float,
                            light: Float,
                          onSuccess success: @escaping (_ response: Any) -> Void,
                          onFailure failure: @escaping (_ error: Error) -> Void){
    API.userProvider.request(.updateAlerts(userId: userId, vib: vib, hum: hum, temp: temp, light: light) ) { result in
      handleResponse(result: result, to: User.self, onSuccess: success, onFailure: failure)
    }
  }
}

