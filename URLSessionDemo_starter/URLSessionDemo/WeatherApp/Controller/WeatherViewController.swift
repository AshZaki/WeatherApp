//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Williamson, Folarin on 5/1/19.
//  Copyright © 2019 Williamson, Folarin. All rights reserved.
//  Starter

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var temperature: UILabel!
    
    var city = CityManager.fetchCity("Chicago")
    let apiKey = "2d96dd3d19c9b16f14bcd27756c90d34"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let city = city else { return }
        
         // Call Dark Sky API HERE
        let url = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(city.latitude),\(city.longitude)")
        
        let task = URLSession.shared.dataTask(with: url!){ (data, response, error) in
            
            if error != nil {
                print(error!)
            }
            
            let weatherForecast = WeatherDataManager.forecast(data!, city: city)
            DispatchQueue.main.async {[weak self] in
                self?.iconView.image = UIImage(named: "\(weatherForecast.icon.rawValue)-large")
                self?.locationLabel.text = "\(weatherForecast.city), \(weatherForecast.state)"
                self?.temperature.text = "\(weatherForecast.currentTemperature)°"
            }

        }
       
        task.resume()
        
    }
}


