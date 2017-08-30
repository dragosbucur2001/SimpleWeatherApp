//
//  Location.swift
//  WeatherApp
//
//  Created by Ionut-Daniel Ciubotariu on 11/08/2017.
//  Copyright © 2017 Bucur Dragos. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init  () {}
    var lat: Double!
    var lon: Double!

}
