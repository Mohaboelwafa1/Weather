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

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")
        DispatchQueue.global(qos: .background).async {
            self.citiesListViewModel.getCitiesList(completionHandler: {
                (result, statusCode, errorModel)in
                self.distinictCitiesList = result
                self.listOfCitiesTable.reloadData()
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
