//  Wine Add Controller
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

class WineAddController{
  
  var rootView: UIViewController!
  var sensors: [Sensor] = []
  var _stationId:String?
  var stationId: String{
    get{
      return _stationId!
    }
    set(newStation){
      _stationId = newStation
      API.getSensors(stationId: newStation, ofUserId: (Config.User?.id)!, onSuccess: { sensors in
        let convertedSensor = (sensors as! Array<API.Sensor>)
        if convertedSensor.count == 0{
          self.rootView.dismiss(animated: true, completion: nil)
          self.showError(API.ErrorCertiWine(message: API.ErrorType.sensorError.rawValue))
        }
        for (_, sensor) in convertedSensor.enumerated(){
          self.sensors.append(Sensor(apiModel: sensor))
        }
      }, onFailure: showError)
    }
  }
  
  init(rootViewController: UIViewController){
    rootView = rootViewController
  }
  
  func save(name: String, info: String, sensorId: String, year: Date) {
    API.createWine(name: name, year: 1990, info: info, sensorId: sensorId, userId: (Config.User?.id)!, stationId: stationId, onSuccess: { wine in
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
      self.rootView.dismiss(animated: true, completion: nil)
    }, onFailure: showError)
  }
  
  func showError(_ err:Error){
    let error = err as! API.ErrorCertiWine
    let alertController = UIAlertController(title: "Application Error", message: error.message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
    rootView.present(alertController, animated: true, completion: nil)
  }
}
