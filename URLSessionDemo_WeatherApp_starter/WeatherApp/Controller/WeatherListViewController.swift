//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Williamson, Folarin on 5/1/19.
//  Copyright © 2019 Williamson, Folarin. All rights reserved.
//

import UIKit
import MapKit

class WeatherListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    public static let weatherCellID = String(describing: WeatherCell.self)
    public static let weatherListSectionHeaderID = String(describing: WeatherListSectionHeaderView.self)
    
    var dataSource: WeatherListDataSource = WeatherListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: String(describing: WeatherListSectionHeaderView.self), bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: WeatherListViewController.weatherListSectionHeaderID)
        
        let cellNib = UINib(nibName: String(describing: WeatherCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: WeatherListViewController.weatherCellID)
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        dataSource.handler = {[weak self] in
            DispatchQueue.main.async() {
                self?.tableView.reloadData()
            }
        }
        dataSource.makeAPICall(cityName: "WashingtonD.C")
        dataSource.makeAPICall(cityName: "SanFrancisco")
        dataSource.makeAPICall(cityName: "Miami")
        dataSource.makeAPICall(cityName: "Philadelphia")
    }
}

