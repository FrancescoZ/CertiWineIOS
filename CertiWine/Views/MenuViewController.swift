//
//  MenuViewController.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 05/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//


import UIKit


class MenuViewController: UIViewController,CircleMenuDelegate{
  
  
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var menuButton: CircleMenu!

  
  let items: [(icon: String, color: UIColor)] = [
    ("logout", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
    ("explore", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
    ("follower", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
    ("settings", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
    ("byhashtag", UIColor(red:1, green:0.39, blue:0, alpha:1)),
    ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()    }
  
  override func viewDidAppear(_ animated: Bool) {
    menuButton.layer.cornerRadius = menuButton.frame.size.width / 2.0
    menuButton.sendActions(for: .touchUpInside)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func unwindToViewController(){
    self.dismiss(animated: true, completion: nil)
  }
  
  func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
    button.backgroundColor = items[atIndex].color
    
    button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
    
    // set highlited image
    let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
    button.setImage(highlightedImage, for: .highlighted)
    button.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
  }
  
  func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
    
  }
  
  func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
    print("button did selected: \(atIndex)")
//    switch atIndex{
//    case 0:
//      let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! ImageCommentViewController
//      self.present(secondViewController, animated: true)
//    case 1:
//      let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingComment") as! SettingCommentViewController
//      self.present(secondViewController, animated: true)
//      break
//    case 2:
//      let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
//      self.present(secondViewController, animated: true)
//      break
//    case 3:
//      self.api.logout()
//      let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "thanksView") as! SettingsViewController
//      self.present(secondViewController, animated: true)
//    default:
//      break
//    }
    
  }
  
  func menuCollapsed(_ circleMenu: CircleMenu){
    //self.performSegue(withIdentifier: "unwindToMenu", sender: self)
  }
  
}

