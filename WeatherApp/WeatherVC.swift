//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ionut-Daniel Ciubotariu on 10/08/2017.
//  Copyright © 2017 Bucur Dragos. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    @IBOutlet weak var currentTemperatureLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationLbl: UILabel!
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        tableView.dataSource = self
        tableView.delegate = self
      //  forecast = Forecast(weatherDict: Dictionary<String, AnyObject>)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.lat = currentLocation.coordinate.latitude
            Location.sharedInstance.lon = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData() {
                    self.updateMainUI()
                }
                
            }
            
        }  else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: _forecastURL)
        Alamofire.request(forecastURL!).responseJSON {
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else  {
            return WeatherCell()
        }
        
    }


    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTemperatureLbl.text = "\(currentWeather.currentTemp).0°"
        currentWeatherType.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }


}

