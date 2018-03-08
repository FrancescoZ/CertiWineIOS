//  WinesTableViewController
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

class WinesTableViewController: UIViewController{
  
  lazy var winesController = WinesController(rootViewController: self)
  var stationId: String = ""
  var stationName: String?
  @IBOutlet weak var winesTableView: UITableView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var addViewController: WineAddViewContoller!
  
  override func viewDidLoad() {
    titleLabel.text = stationName! + "'s Wines"
    NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name: NSNotification.Name(rawValue: "refresh"), object: nil)
  }
  
  @objc func refreshList(notification: NotificationCenter){
    winesController.stationId = stationId
  }
  
  @IBAction func addTouch(_ sender: UIButton) {
    addViewController = self.storyboard?.instantiateViewController(withIdentifier: "WineAddViewController") as! WineAddViewContoller
    addViewController.wineAddController.stationId = winesController.stationId
    self.show(addViewController, sender: self)
  }
}

extension WinesTableViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return winesController.data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell", for: indexPath) as! WineCell
    cell.setup(withText: winesController.data[indexPath.row].name)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let next = self.storyboard?.instantiateViewController(withIdentifier: "WinesTableViewController") as! WinesTableViewController
//    next.winesController.stationId = stationsController.data[indexPath.row].id
//    next.stationName = stationsController.data[indexPath.row].name
//    self.show(next, sender: self)  
  }
  
}

