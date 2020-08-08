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
    @IBOutlet weak var backGroundImage: UIImageView!

    private let refreshControl = UIRefreshControl()
    var citiesListViewModel: CitiesListViewModel_View  = CitiesListViewModel_Model()
    var cellsModel: [CityCellModel] = [CityCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchWeatherData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listOfCitiesTable.backgroundColor = .clear
        self.listOfCitiesTable.isOpaque = false;
    }

    func setupView() {
        self.navigationItem.setHidesBackButton(true, animated: true)

        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")

        listOfCitiesTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)

        self.backGroundImage.image = UIImage(named: "NightBG")
        self.backGroundImage.alpha = 0.05
    }

    func fetchWeatherData() {
        _ = citiesListViewModel.getCitiesListOffline()
        cellsModel = citiesListViewModel.prepareCellModel()
        self.listOfCitiesTable.isHidden = false
        self.refreshControl.endRefreshing()
    }

    @objc private func refreshWeatherData(_ sender: Any) {
        if Utilities.shared.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                self.citiesListViewModel.getCitiesList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        self.refreshControl.endRefreshing()
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
        return self.cellsModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCitiesTable!.dequeueReusableCell(withIdentifier: "CustomCityCell")! as! CustomCityCell
        (cell as! CustomCityCell).setModel(model: cellsModel[indexPath.row])
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
        cityDetailsViewController.cityName = self.cellsModel[indexPath.row].cityName
        self.navigationController?.pushViewController(cityDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
