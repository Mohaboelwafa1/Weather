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

class CitiesListViewController: UIViewController {

    @IBOutlet weak var listOfCitiesTable : UITableView!
    var citiesListViewModel: CitiesListViewModel_View  = CitiesListViewModel_Model()
    var citiesList : [CitiesResponseModel] = [CitiesResponseModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")
        DispatchQueue.global(qos: .background).async {
            self.citiesListViewModel.getCitiesList(completionHandler: {
                (result, statusCode, errorModel)in
                self.citiesList = result
                self.listOfCitiesTable.reloadData()
            })
        }

    }

}
extension CitiesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citiesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCitiesTable!.dequeueReusableCell(withIdentifier: "CustomCityCell")! as! CustomCityCell
        var model : CityCellModel = CityCellModel()
        model.cityName = self.citiesList[indexPath.row].city?.name ?? "Loading ..."
        model.currentTime = self.citiesList[indexPath.row].date ?? "Loading ..."
        model.tempreture = "\(String(describing: self.citiesList[indexPath.row].temp!))"
        model.backGroundImage = self.citiesList[indexPath.row].city?.picture ?? ""
        (cell as! CustomCityCell).setModel(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


extension CitiesListViewController : UITableViewDelegate {

}
