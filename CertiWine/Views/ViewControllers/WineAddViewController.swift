//  Wine Add View Controller
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
import Charts

class WineAddViewContoller: UIViewController{
  
  @IBOutlet weak var infoTextView: UITextView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var sensorPicker: UIPickerView!
  @IBOutlet weak var imageView: UIImageView!
  
  lazy var wineAddController = WineAddController(rootViewController: self)
  
  override func viewDidLoad() {
    infoTextView.text = "Wine Information"
    infoTextView.textColor = UIColor.lightGray
    
    imageView.roundedImage()
  }
  
  @IBAction func backTouch(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension WineAddViewContoller: UIPickerViewDelegate, UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return wineAddController.sensors.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return wineAddController.sensors[row].name
  }
  

}

extension WineAddViewContoller: UITextViewDelegate{
  func textViewDidBeginEditing(_ textField: UITextView) {
    if infoTextView.textColor == UIColor.lightGray {
      infoTextView.text = nil
      infoTextView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textField: UITextView) {
    if infoTextView.text.isEmpty {
      infoTextView.text = "Wine Information"
      infoTextView.textColor = UIColor.lightGray
    }
  }
}

