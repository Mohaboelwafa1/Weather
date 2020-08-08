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

class CitiesListViewController: UIViewController {

    @IBOutlet weak var listOfCitiesTable : UITableView!
    var citiesListViewModel: CitiesListViewModel_View  = CitiesListViewModel_Model()
    var distinictCitiesList : Results<CitiesDBModel>?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUTableView()
        fetchWeatherData()
    }

    func fetchWeatherData() {
        DispatchQueue.global(qos: .background).async {
            self.citiesListViewModel.getCitiesList(completionHandler: {
                (result, statusCode, errorModel)in
                self.distinictCitiesList = result
                self.listOfCitiesTable.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
    }

    func setUTableView() {
        self.navigationItem.setHidesBackButton(true, animated: true);
        listOfCitiesTable.delegate = self
        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")
        if #available(iOS 10.0, *) {
            listOfCitiesTable.refreshControl = refreshControl
        } else {
            listOfCitiesTable.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    }

    @objc private func refreshWeatherData(_ sender: Any) {
        fetchWeatherData()
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
        model.currentTime = Utilities.shared.getDate(date: self.distinictCitiesList?[indexPath.row].date)
        let temp = Utilities.shared.ConvertTempreture(
            temp: self.distinictCitiesList?[indexPath.row].temp ?? 0,
            type: self.distinictCitiesList?[indexPath.row].tempType ?? "C"
        )
        model.tempreture = "\(temp)"
        model.backGroundImage = self.distinictCitiesList?[indexPath.row].cityPicture ?? ""
        (cell as! CustomCityCell).setModel(model: model)
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
        self.navigationController?.pushViewController(cityDetailsViewController, animated: true)
    }
}
