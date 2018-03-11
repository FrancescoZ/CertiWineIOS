//  Manager Wine Controller
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

import UIKit

extension ManagerController{
  
  @objc func getAllWines(notification: NotificationCenter){
    API.getAllWines(userId: Shared.UserId, onSuccess: { wines in
      Config.User?.addWines(wines: wines as! Array<API.Wine>)
      Shared.Wines = (Config.User?.wines)!
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAllWinesTableView"), object: nil)
    }, onFailure: self.showError)
  }
  
  @objc func getWine(notification: NotificationCenter){
    API.getWine(withId: Shared.WineId, sensorId: Shared.SensorId, userId: Shared.UserId, stationId: Shared.StationId, onSuccess: { wine in
      Shared.Wine = Wine(apiModel: wine as! API.Wine)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshWineData"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getValues"), object: nil)
    }, onFailure: self.showError)
  }
  
  @objc func refreshWines(notification: NotificationCenter){
    API.getWines(userId: Config.ID, stationId: Shared.StationId, onSuccess: { wines in
      Config.User?.addWines(wines: wines as! Array<API.Wine>)
      Shared.Wines = (Config.User?.wines)!
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshWinesTableView"), object: nil)
    }, onFailure: self.showError)
  }
  
  @objc func saveWine(notification: Notification) {
    let wineModel = notification.object as! Wine
    API.createWine(name: wineModel.name, year: wineModel.year, info: wineModel.info, sensorId: wineModel.sensor, userId: Shared.UserId, stationId: Shared.StationId, onSuccess: { wine in
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshWines"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismiss"), object: nil)
    }, onFailure: showError)
  }
  
  @objc func getValues(notification: NotificationCenter){
    API.getWineValues(withId: Shared.WineId, sensorId: Shared.SensorId, userId: Shared.UserId, stationId: Shared.StationId, onSuccess: { values in
      for (_, value) in (values as! Array<API.Value>).enumerated(){
        Shared.Values.append(Value(apiModel: value))
      }
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshCharts"), object: nil)
    }, onFailure: self.showError)
  }

}
