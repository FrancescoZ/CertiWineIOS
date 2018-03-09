//  ProfileViewController
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

class ProfileViewController: UIViewController{
  
  var changed:Bool = false
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  @IBOutlet weak var vibrationLabel: UILabel!
  @IBOutlet weak var vibrationSlider: UISlider!
  
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var temperatureSlider: UISlider!
  
  @IBOutlet weak var lightLabel: UILabel!
  @IBOutlet weak var lightSlider: UISlider!
  
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var humiditySlider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(refreshInterface), name: NSNotification.Name(rawValue: "refreshProfileView"), object: nil)
    refresh()
  }
  
  func refresh(){
    profileImageView.layer.borderWidth = 1
    profileImageView.layer.masksToBounds = false
    profileImageView.layer.borderColor = UIColor.black.cgColor
    
    profileImageView.roundedImage()
    
    nameLabel.text = Config.User?.fullName
    emailLabel.text = Config.User?.email
    
    vibrationSlider.value = (Config.User?.settings.maxVibration)!
    lightSlider.value = (Config.User?.settings.maxLight)!
    humiditySlider.value = (Config.User?.settings.maxHumidity)!
    temperatureSlider.value = (Config.User?.settings.maxTemperature)!
    
    humidityLabel.text = String(humiditySlider.value) + "%"
    vibrationLabel.text = String(vibrationSlider.value) + " vib/min"
    temperatureLabel.text = String(temperatureSlider.value)+" °C"
    lightLabel.text = String(lightSlider.value) + " lumen"
  }
  
  @objc func refreshInterface(notification: Notification){
    refresh()
  }
  
  @IBAction func menuTouch(_ sender: UIButton) {
    let _ = Config.User?.save()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateUser"), object: nil)
    let viewControllerType: ViewControllerType = .Menu
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
  
  @IBAction func temperatureSlideChanged(_ sender: Any) {
    temperatureLabel.text = String(temperatureSlider.value)+" °C"
    Config.User?.settings.maxTemperature = temperatureSlider.value
  }
  
  @IBAction func lightSlideChanged(_ sender: Any) {
    lightLabel.text = String(lightSlider.value) + " lumen"
    Config.User?.settings.maxLight = lightSlider.value
  }
  
  @IBAction func vibrationSlideChanged(_ sender: Any)  {
    vibrationLabel.text = String(vibrationSlider.value) + " vib/min"
    Config.User?.settings.maxVibration = vibrationSlider.value
  }
  
  @IBAction func humiditySlideChanged(_ sender: Any) {
    humidityLabel.text = String(humiditySlider.value) + "%"
    Config.User?.settings.maxHumidity = humiditySlider.value
  }
}
