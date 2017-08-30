//
//  Constants.swift
//  WeatherApp
//
//  Created by Ionut-Daniel Ciubotariu on 10/08/2017.
//  Copyright © 2017 Bucur Dragos. All rights reserved.
//

import Foundation
let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
let lat = "lat="
let lon = "&lon="
let appID = "&appid="
let apiKey = "cc5f4b2a1bc36ef0534b1019f2ae42f4"

typealias DownloadComplete = () -> ()

let currentWeatherURL = "\(baseURL)\(lat)\(Location.sharedInstance.lat!)\(lon)\(Location.sharedInstance.lon!)\(appID)\(apiKey)"

let _forecastURL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.lat!)&lon=\(Location.sharedInstance.lon!)&cnt=10&appid=cc5f4b2a1bc36ef0534b1019f2ae42f4"
