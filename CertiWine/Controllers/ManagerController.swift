//
//  ManagerController.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 08/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

enum ViewControllerType{
  case Wines
  case AddWine
  case WineDetail
  case Stations
  case SensorDetail
  case Profile
  case SearchWine
  case Menu
  case None
  case Login
  case Thanks
}

class ManagerController{
  init(currentViewController: UIViewController){
    Shared.currentViewController = currentViewController
    NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name(rawValue: "logout"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshWines), name: NSNotification.Name(rawValue: "refreshWines"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(getAllWines), name: NSNotification.Name(rawValue: "getAllWines"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshStations), name: NSNotification.Name(rawValue: "refreshStations"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshValues), name: NSNotification.Name(rawValue: "refreshValues"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshSensors), name: NSNotification.Name(rawValue: "refreshSensors"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(loadUser), name: NSNotification.Name(rawValue: "refreshUser"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateUser), name: NSNotification.Name(rawValue: "updateUser"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleError), name: NSNotification.Name(rawValue: "handleError"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(pushViewController), name: NSNotification.Name(rawValue: "pushViewController"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(dismiss), name: NSNotification.Name(rawValue: "dismiss"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(getWine), name: NSNotification.Name(rawValue: "getWine"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(saveWine), name: NSNotification.Name(rawValue: "saveWine"), object: nil)

  }
  
}

extension ManagerController{
  
  @objc func pushViewController(notification: Notification){
    let type: ViewControllerType = notification.object as! ViewControllerType
    let storyBoardName: String
    switch type{
    case .Stations:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshStations"), object: nil)
      storyBoardName = "StationsTableViewController"
    case .WineDetail:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getWine"), object: nil)
      storyBoardName = "WineDetailViewController"
    case .Wines:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshWines"), object: nil)
      storyBoardName = "WinesTableViewController"
    case .SensorDetail:
      storyBoardName = "SensorDetailViewController"
    case .Profile:
      storyBoardName = "ProfileViewController"
    case .AddWine:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshSensors"), object: nil)
      storyBoardName = "WineAddViewController"
    case .SearchWine:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getAllWines"), object: nil)
      storyBoardName = "SearchWinesViewController"
    case .Menu, .None:
      storyBoardName = "MenuViewController"
    case .Login:
      storyBoardName = "LoginTutorialViewController"
    case .Thanks:
      storyBoardName = "ThanksViewController"
    }
    let next = Shared.currentViewController?.storyboard?.instantiateViewController(withIdentifier: storyBoardName)
    Shared.oldViewController = Shared.currentViewController
    Shared.currentViewController?.present(next!, animated: true)
    Shared.currentViewController = next
  }
 
  @objc func handleError(notification: NotificationCenter){}
  
  @objc func logout(notification: NotificationCenter){
    let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel,handler: { (action: UIAlertAction!) in
      let viewControllerType: ViewControllerType = .Menu
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    }))
    alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
      KeychainWrapper.standard.removeObject(forKey: Config.authVar)
      KeychainWrapper.standard.removeObject(forKey: Config.idVar)
      let viewControllerType: ViewControllerType = .Thanks
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    }))
    Shared.currentViewController?.present(alertController, animated: true, completion: nil)
  }
  
  @objc func dismiss(notification: NotificationCenter){
    let temp = Shared.oldViewController
    Shared.oldViewController = Shared.currentViewController
    Shared.currentViewController?.dismiss(animated: true, completion: nil)
    Shared.currentViewController = temp
  }
  
  
  
  func showError(_ err:Error){
    let error = err as! API.ErrorCertiWine
    let alertController = UIAlertController(title: "Application Error", message: error.message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
    Shared.currentViewController?.present(alertController, animated: true, completion: nil)
  }
}
