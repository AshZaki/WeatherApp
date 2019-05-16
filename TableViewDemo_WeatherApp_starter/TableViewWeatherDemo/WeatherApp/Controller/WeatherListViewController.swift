//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Williamson, Folarin on 5/1/19.
//  Copyright © 2019 Williamson, Folarin. All rights reserved.
// Starter

import UIKit
import MapKit

class WeatherListViewController: UIViewController {
    // TO DO: add a table view to the Main.storyboard file
    // TO DO: wire up your table view that you placed in Main.storyboard
    
    public static let weatherListSectionHeaderID = String(describing: WeatherListSectionHeaderView.self)
    
    var dataSource: WeatherListDataSource = WeatherListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: String(describing: WeatherListSectionHeaderView.self), bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: WeatherListViewController.weatherListSectionHeaderID)
        
        // TO DO: reuse identifier
        let cellNib = UINib(nibName: String(describing: WeatherCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "weatherCell")
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        dataSource.handler = {[weak self] in
            DispatchQueue.main.async() {
                self?.tableView.reloadData()
            }
        }
        
        dataSource.makeAPICall(cityName: "Miami")
        dataSource.makeAPICall(cityName: "Philadelphia")
    }
}
