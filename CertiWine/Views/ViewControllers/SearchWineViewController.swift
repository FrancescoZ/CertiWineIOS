//  Search Wine View Controller
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

class SearchWineViewController: UIViewController{
  
  var filteredWine = [Wine]()
  
  @IBOutlet weak var winesTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    searchBar.delegate = self
    filteredWine = Shared.Wines
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "refreshAllWinesTableView"), object: nil)
    super.viewDidLoad()
  }
  
  @IBAction func menuTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Menu
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
}

extension SearchWineViewController: UITableViewDataSource, UITableViewDelegate {
  @objc func refreshTableView(notification: NotificationCenter){
    filteredWine = Shared.Wines
    winesTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredWine.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WineAllCell", for: indexPath) as! WineAllCell
    cell.setup(withText: filteredWine[indexPath.row].name)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    Shared.WineId = filteredWine[indexPath.row].id
    Shared.WineName = filteredWine[indexPath.row].name
    Shared.SensorId = filteredWine[indexPath.row].sensor
    
    tableView.deselectRow(at: indexPath, animated: true)
    let viewControllerType: ViewControllerType = .WineDetail
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    
  }
}

extension SearchWineViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      filteredWine = searchText.isEmpty ? Shared.Wines : Shared.Wines.filter({(obj: Wine) -> Bool in
        return obj.name.lowercased().contains(searchText.lowercased())
      })
      winesTableView.reloadData()
  }
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool{
    return true
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
    
  }
  

  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
   return true
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    
  }
}
