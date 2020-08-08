//
//  CityDetailsViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CityDetailsViewController: UIViewController {

    var cityName: String?
    @IBOutlet weak var listOfCityDegrees : UITableView!
    var degreesList : Results<CitiesDBModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUTableView()
        getCityData()

    }

    func getCityData(){
        let realm = try! Realm()
        degreesList = realm.objects(CitiesDBModel.self).filter("cityName = '\(cityName!)'").sorted(byKeyPath: "date", ascending: true)
    }


    func setUTableView() {
        listOfCityDegrees.register(CustomTempDegreeCell.self, forCellReuseIdentifier: "CustomTempDegreeCell")
        //listOfCityDegrees.register(UINib(nibName: "CustomTempDegreeCell",bundle: nil), forCellReuseIdentifier: "CustomTempDegreeCell")
        self.listOfCityDegrees.register(UINib(nibName: "CustomTempDegreeCell",bundle: nil), forCellReuseIdentifier: "CustomTempDegreeCell")
    }

}

extension CityDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.degreesList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCityDegrees!.dequeueReusableCell(withIdentifier: "CustomTempDegreeCell")! as! CustomTempDegreeCell
        var model : CustomTempDegreeCellModel = CustomTempDegreeCellModel()
        model.currentTime = (self.degreesList?[indexPath.row].date)!
        model.todayDate = (self.degreesList?[indexPath.row].date)!
        model.tempreture = "\(self.degreesList?[indexPath.row].temp)"
        model.iconImage = "test"
        (cell as! CustomTempDegreeCell).setModel(model: model)
        return cell
    }

}

