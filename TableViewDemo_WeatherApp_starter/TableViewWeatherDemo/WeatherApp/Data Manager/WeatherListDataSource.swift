//
//  WeatherListDataSource.swift
//  WeatherApp
//
//  Created by Williamson, Folarin on 5/5/19.
//  Copyright © 2019 Williamson, Folarin. All rights reserved.
//

import UIKit

typealias WeatherDataCompletionHandler = () -> Void

class WeatherListDataSource: NSObject {
    var weatherItems: [WeatherData] = []
    var handler: WeatherDataCompletionHandler?
    
    public func makeAPICall(cityName: String) {
        guard let city = CityManager.fetchCity(cityName) else { return }
        
        DarkSkyClient.request(city: city) {[weak self] result in
            switch result {
            case let .success(weatherData):
                self?.weatherItems.append(weatherData)
                self?.handler?()
            case let .error(error):
                print("ERROR: \(error)")
            }
        }
    }
}


extension WeatherListDataSource: UITableViewDataSource {

    // TO DO: there's a missing function here
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TO DO: What type of cell should your table view use?
        // TO DO: Where's the data?
        
        cell.configure(data)
        return cell
    }
}

extension WeatherListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherListViewController.weatherListSectionHeaderID) as? WeatherListSectionHeaderView else {
            fatalError("Can't configure WeatherListSectionHeaderView; header ID is incorrect")
        }
        
        header.titleLabel.text = "Locations"
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
