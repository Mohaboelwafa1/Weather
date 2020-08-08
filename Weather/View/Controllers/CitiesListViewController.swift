//
//  CitiesListViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Toast_Swift

class CitiesListViewController: UIViewController {

    @IBOutlet weak var listOfCitiesTable : UITableView!
    var citiesListViewModel: CitiesListViewModel_View  = CitiesListViewModel_Model()
    var citiesList : Results<CitiesDBModel>?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUTableView()
        fetchWeatherData()
    }

    func setUTableView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    }

    func fetchWeatherData() {
        let realm = try! Realm()
        citiesList = realm.objects(CitiesDBModel.self).distinct(by: ["cityName"]).sorted(byKeyPath: "cityName", ascending: true)
        self.refreshControl.endRefreshing()
    }

    @objc private func refreshWeatherData(_ sender: Any) {
        if Utilities.shared.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                self.citiesListViewModel.getCitiesList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        self.refreshControl.endRefreshing()
                        self.citiesList = result
                    }
                })
            }
        } else {
            self.refreshControl.endRefreshing()
            _ = Utilities.shared.showConnectionError(
                view: self,
                title: "Connection error",
                duration: 1.0,
                message: "Make sure of connection",
                image: "CloudyIcon.png"
            )
        }
    }

}
extension CitiesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.citiesList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCitiesTable!.dequeueReusableCell(withIdentifier: "CustomCityCell")! as! CustomCityCell
        var model : CityCellModel = CityCellModel()

        model.cityName = self.citiesList?[indexPath.row].cityName ?? "Loading ..."
        model.currentTime = Utilities.shared.getDate(date: self.citiesList?[indexPath.row].date)
        let temp = Utilities.shared.ConvertTempreture(
            temp: self.citiesList?[indexPath.row].temp ?? 0,
            type: self.citiesList?[indexPath.row].tempType ?? "C"
        )
        model.tempreture = "\(temp)"
        model.backGroundImage = self.citiesList?[indexPath.row].cityPicture ?? ""

        (cell as! CustomCityCell).setModel(model: model)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension CitiesListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cityDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "CityDetailsViewController") as! CityDetailsViewController
        cityDetailsViewController.cityName = self.citiesList?[indexPath.row].cityName
        print(self.citiesList?[indexPath.row].cityName)
        self.navigationController?.pushViewController(cityDetailsViewController, animated: true)
    }
}
