//
//  CitiesListViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RealmSwift

class CitiesListViewController: UIViewController {

    @IBOutlet weak var listOfCitiesTable : UITableView!
    var citiesListViewModel: CitiesListViewModel_View  = CitiesListViewModel_Model()
    var distinictCitiesList : Results<CitiesDBModel>?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            listOfCitiesTable.refreshControl = refreshControl
        } else {
            listOfCitiesTable.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)

        DispatchQueue.global(qos: .background).async {
            self.citiesListViewModel.getCitiesList(completionHandler: {
                (result, statusCode, errorModel)in
                self.distinictCitiesList = result
                self.listOfCitiesTable.reloadData()
            })
        }

    }

    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        DispatchQueue.global(qos: .background).async {
            self.citiesListViewModel.getCitiesList(completionHandler: {
                (result, statusCode, errorModel)in
                self.distinictCitiesList = result
                self.listOfCitiesTable.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
    }

    func ConvertTempreture(temp: Double , type: String) -> Double {
        switch type {
           case "C":
               return temp
           case "K":
               return  Double(round(100*(temp - 273.15))/100)
           case "F":
               return  Double(round(100*((temp - 32) / 1.8))/100)
           default:
               return temp
           }
       }
}
extension CitiesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.distinictCitiesList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCitiesTable!.dequeueReusableCell(withIdentifier: "CustomCityCell")! as! CustomCityCell
        var model : CityCellModel = CityCellModel()
        model.cityName = self.distinictCitiesList?[indexPath.row].cityName ?? "Loading ..."
        model.currentTime = self.distinictCitiesList?[indexPath.row].date ?? "Loading ..."
        model.tempreture = "\(self.ConvertTempreture(temp: self.distinictCitiesList?[indexPath.row].temp ?? 0, type: self.distinictCitiesList?[indexPath.row].tempType ?? "C"))"
        model.backGroundImage = self.distinictCitiesList?[indexPath.row].cityPicture ?? ""
        (cell as! CustomCityCell).setModel(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


extension CitiesListViewController : UITableViewDelegate {

}
