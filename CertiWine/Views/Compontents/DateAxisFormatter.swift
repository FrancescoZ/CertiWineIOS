//
//  DateLineChartView.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 11/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import Foundation
import Charts

class DateAxisFormatter: NSObject, IAxisValueFormatter {
  
  lazy private var dateFormatter: DateFormatter = {
    // set up date formatter using locale
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()

  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let index = Int(value)
    let scores = Shared.Values
    guard scores.count > 0,
          index < scores.count,
      let date = scores[index].date else {
      return "?"
    }
    
    return dateFormatter.string(from: date)
  }
}
