//
//  StationCell.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 06/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import Foundation
import UIKit

class StationCell: UITableViewCell{
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var stationImageView: UIImageView!
  
  func setup(withText text: String) {
    stationImageView.image = #imageLiteral(resourceName: "grapes-blue")
    stationImageView.roundedImage()
    
    nameLabel.text = text
  }
  
}
