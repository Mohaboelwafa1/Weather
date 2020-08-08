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
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    var degreesList : Results<CitiesDBModel>?
    var cityDetailsViewModel: CityDetailsViewModel_View  = CityDetailsViewModel_Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCityData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listOfCityDegrees.backgroundColor = .clear
        self.listOfCityDegrees.isOpaque = false;
    }

    func setupView() {
        cityNameLabel.text = cityName!
        listOfCityDegrees.register(CustomTempDegreeCell.self, forCellReuseIdentifier: "CustomTempDegreeCell")
        self.listOfCityDegrees.register(UINib(nibName: "CustomTempDegreeCell",bundle: nil), forCellReuseIdentifier: "CustomTempDegreeCell")
        self.backGroundImage.image = UIImage(named: "NightBG")
    }

    func getCityData(){
        degreesList = cityDetailsViewModel.getCityData(cityName: cityName!)
    }

}

extension CityDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.degreesList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCityDegrees!.dequeueReusableCell(withIdentifier: "CustomTempDegreeCell")! as! CustomTempDegreeCell
        var model : CustomTempDegreeCellModel = CustomTempDegreeCellModel()
        let dateAndTime = (self.degreesList?[indexPath.row].date)!
        let degree = self.degreesList?[indexPath.row].temp ?? 0
        let celsuisDegree = cityDetailsViewModel.ConvertTempreture(temp: degree, type: (self.degreesList?[indexPath.row].tempType)!)

        model.currentTime = cityDetailsViewModel.getTime(date: dateAndTime)
        model.todayDate = cityDetailsViewModel.getDate(date: dateAndTime)
        model.tempreture = "\(celsuisDegree) °"
        model.iconImage = cityDetailsViewModel.getImageName(degree: celsuisDegree)

        (cell as! CustomTempDegreeCell).setModel(model: model)
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CityDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

