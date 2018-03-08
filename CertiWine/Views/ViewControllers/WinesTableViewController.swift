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
  
  @IBOutlet weak var winesTableView: UITableView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var addViewController: WineAddViewContoller!
  
  override func viewDidLoad() {
    titleLabel.text = Shared.StationName + "'s Wines"
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "refreshWinesTableView"), object: nil)
    super.viewDidLoad()
  }
  
  @IBAction func backTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Stations
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
  
  @IBAction func addTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .AddWine
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
}

extension WinesTableViewController: UITableViewDataSource, UITableViewDelegate {
  @objc func refreshTableView(notification: NotificationCenter){
    winesTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Shared.Wines.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell", for: indexPath) as! WineCell
    cell.setup(withText: Shared.Wines[indexPath.row].name)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    Shared.WineId = Shared.Wines[indexPath.row].id
    Shared.WineName = Shared.Wines[indexPath.row].name
    Shared.SensorId = Shared.Wines[indexPath.row].sensor
    
    tableView.deselectRow(at: indexPath, animated: true)
    let viewControllerType: ViewControllerType = .WineDetail
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)

  }
  
}

