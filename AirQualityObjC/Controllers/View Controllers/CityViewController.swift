//
//  CityViewController.swift
//  AirQualityObjC
//
//  Created by Aaron Shackelford on 12/4/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    

    var city: String?
    var state: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
        let state = state,
        let country = country
        else { return }
        
        ARCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (city) in
            if let conditions = city {
                self.updateViews(with: conditions)
            }
        }
    }
    
    func updateViews(with conditions: ARCityAirQuality) {
        DispatchQueue.main.async {
            self.cityLabel.text = conditions.city
            self.stateLabel.text = conditions.state
            self.countryLabel.text = conditions.country
            self.tempLabel.text = "Temp: \(conditions.weather.temperature) degrees"
            self.humidityLabel.text = "Humidity: \(conditions.weather.humidity)%"
            self.aqiLabel.text = "AQI: \(conditions.pollution.airQualityIndex)"
            self.windSpeedLabel.text = "Wind Speed: \(conditions.weather.windSpeed)mph"
        }
    }
}
