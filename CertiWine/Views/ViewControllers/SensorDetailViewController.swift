//
//  SensorDetailViewController.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 10/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import UIKit
import Charts

class SensorDetailViewController: UIViewController{
  
  @IBOutlet weak var sensorChart: LineChartView!
  
 
  
  override func viewDidLoad() {
    setChart()
  }
  
  func setChart() {
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
    var dataEntries: [ChartDataEntry] = []
   
    for i in 0..<months.count {
      let dataEntry = ChartDataEntry(x: Double(i), y: Double(unitsSold[i]))
      dataEntries.append(dataEntry)
    }
    let chartDataSet = LineChartDataSet(values: dataEntries, label: "Visitor count")
    
    chartDataSet.lineWidth = 1.75
  
    chartDataSet.drawCirclesEnabled = false
    chartDataSet.mode =  .horizontalBezier
    chartDataSet.drawValuesEnabled = false
    chartDataSet.drawFilledEnabled = true
    chartDataSet.cubicIntensity = 0.5;
    
    let chartData = LineChartData(dataSet: chartDataSet)
    sensorChart.data = chartData
  }
}
