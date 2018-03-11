//  Wine Detail View Controller
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

class WineDetailViewContoller: UIViewController{
  @IBOutlet weak var wineImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var informationLabel: UILabel!
  @IBOutlet weak var temperatureChart: LineChartView!
  @IBOutlet weak var humidityChart: LineChartView!
  @IBOutlet weak var vibrationChart: LineChartView!
  @IBOutlet weak var lightChart: LineChartView!
  
  
  override func viewDidLoad() {
    refreshInterface()
    NotificationCenter.default.addObserver(self, selector: #selector(refreshWine), name: NSNotification.Name(rawValue: "refreshWineData"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshSensors), name: NSNotification.Name(rawValue: "refreshCharts"), object: nil)
    super.viewDidLoad()
  }
  
  @IBAction func backTouch(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismiss"), object: nil)
  }
  
  @objc func refreshWine(notification: NotificationCenter){
    refreshInterface()
  }
  
  @objc func refreshSensors(notification: NotificationCenter){
    
    setTemperatureChart()
    setLightChart()
    setVibrationChart()
    setHumidityChart()
  }
  
  func refreshInterface(){
    guard let wine = Shared.Wine else{
      return
    }
    nameLabel.text = wine.name
    yearLabel.text = String(describing: wine.year)
    informationLabel.text = wine.info
    wineImage.roundedImage()
  }
  
  func setChart(dataset: LineChartDataSet, xAxis: XAxis) {
    dataset.lineWidth = 1.75
    
    dataset.drawCirclesEnabled = false
    dataset.mode =  .horizontalBezier
    dataset.drawValuesEnabled = false
    dataset.drawFilledEnabled = true
    dataset.cubicIntensity = 0.5;
    
    xAxis.labelPosition = .bottom
    xAxis.labelCount = dataset.entryCount
    xAxis.drawLabelsEnabled = true
    xAxis.drawLimitLinesBehindDataEnabled = true
    xAxis.avoidFirstLastClippingEnabled = true
    // Set the x values date formatter
    let xValuesNumberFormatter = DateAxisFormatter()
    xAxis.valueFormatter = xValuesNumberFormatter
  }
  
  
  func setTemperatureChart(){
    var dataEntries: [ChartDataEntry] = []
    for (index, value) in Shared.Values.enumerated() {
      let dataEntry = ChartDataEntry(x: Double(index), y: Double(value.temperature))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = LineChartDataSet(values: dataEntries, label: "Temperature")
    setChart(dataset: chartDataSet, xAxis: temperatureChart.xAxis)
    let chartData = LineChartData(dataSet: chartDataSet)
    temperatureChart.data = chartData
    temperatureChart.doubleTapToZoomEnabled = false
    temperatureChart.chartDescription?.text = ""
  }
  
  func setLightChart(){
    var dataEntries: [ChartDataEntry] = []
    for (index, value) in Shared.Values.enumerated() {
      let dataEntry = ChartDataEntry(x: Double(index), y: Double(value.light))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = LineChartDataSet(values: dataEntries, label: "Light")
    setChart(dataset: chartDataSet, xAxis: lightChart.xAxis)
    let chartData = LineChartData(dataSet: chartDataSet)
    lightChart.data = chartData
    lightChart.chartDescription?.text = ""
  }
  
  func setVibrationChart(){
    var dataEntries: [ChartDataEntry] = []
    for (index, value) in Shared.Values.enumerated() {
      let dataEntry = ChartDataEntry(x: Double(index), y: Double(value.vibration))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = LineChartDataSet(values: dataEntries, label: "Vibration")
    setChart(dataset: chartDataSet, xAxis: vibrationChart.xAxis)
    let chartData = LineChartData(dataSet: chartDataSet)
    vibrationChart.data = chartData
    vibrationChart.chartDescription?.text = ""
  }
  
  func setHumidityChart(){
    var dataEntries: [ChartDataEntry] = []
    for (index, value) in Shared.Values.enumerated() {
      let dataEntry = ChartDataEntry(x: Double(index), y: Double(value.humidity))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = LineChartDataSet(values: dataEntries, label: "Humidity")
    setChart(dataset: chartDataSet, xAxis: humidityChart.xAxis)
    let chartData = LineChartData(dataSet: chartDataSet)
    humidityChart.data = chartData
    humidityChart.chartDescription?.text = ""
  }
}
