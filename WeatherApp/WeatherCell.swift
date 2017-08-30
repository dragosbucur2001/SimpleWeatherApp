//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Ionut-Daniel Ciubotariu on 11/08/2017.
//  Copyright © 2017 Bucur Dragos. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var hightTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp).0°"
        hightTemp.text = "\(forecast.highTemp).0°"
        weatherType.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }

}
