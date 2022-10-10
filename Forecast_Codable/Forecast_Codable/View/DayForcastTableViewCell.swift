//
//  DayForcastTableViewCell.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayForcastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var forcastedHighLabel: UILabel!
    
    func updateViews(day: Day) {
        dayNameLabel.text = day.validDate
//        iconImageView.image = day.weather.imageString
        forcastedHighLabel.text = "\(day.highTemp)"
        
        
    }
}
