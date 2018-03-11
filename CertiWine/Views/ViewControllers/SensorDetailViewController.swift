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
  @IBOutlet weak var nameLabel: UILabel!
  
  override func viewDidLoad() {
    setChart()
    nameLabel.text = Shared.SensorType.rawValue
  }
  
  func setChart() {
    let xAxis = sensorChart.xAxis
    xAxis.labelPosition = .bottom
    xAxis.labelCount = Shared.SensorValues!.entryCount
    xAxis.drawLabelsEnabled = true
    xAxis.drawLimitLinesBehindDataEnabled = true
    xAxis.avoidFirstLastClippingEnabled = true
    // Set the x values date formatter
    let xValuesNumberFormatter = DateAxisFormatter()
    xAxis.valueFormatter = xValuesNumberFormatter
    sensorChart.data = Shared.SensorValues
  }
  
  @IBAction func backTouch(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismiss"), object: nil)
  }
}
