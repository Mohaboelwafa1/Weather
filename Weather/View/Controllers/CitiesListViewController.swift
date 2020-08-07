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
        model.tempreture = "\(self.distinictCitiesList?[indexPath.row].temp ?? 0)"
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
