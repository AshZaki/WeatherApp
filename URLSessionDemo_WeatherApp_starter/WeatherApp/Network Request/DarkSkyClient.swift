//
//  DarkSkyClient.swift
//  WeatherApp
//
//  Created by Williamson, Folarin on 5/4/19.
//  Copyright © 2019 Williamson, Folarin. All rights reserved.
//

import Foundation

public enum RequestError: Swift.Error {
    case invalidURL
    case responseError
    case noData
}

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case error(Error)
}

typealias DarkSkyCompletionHandler = (Result<WeatherData, RequestError>) -> Void

struct DarkSkyClient {
    // TO DO: insert your Dark Sky API Key here
    private static let apiKey = "2d96dd3d19c9b16f14bcd27756c90d34"
    
    static func request(city: City, completionHandler: @escaping DarkSkyCompletionHandler) {
        // TO DO: Create your URL
        // HINT: The City object has 2 properties you need: 1) latitude 2) longitude
        // HINT Don't forget to use your apiKey
        guard let url = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(city.latitude),\(city.longitude)") else {
           return completionHandler(.error(RequestError.invalidURL))
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            let weatherData = WeatherDataManager.json(data!, city)
            completionHandler(.success(weatherData))

            }
        task.resume()
        
        // TO DO: Create your URLSession + URLSessionDataTask
        // The last 2 lines in your closure should be the 2 lines below
    
    }
}
