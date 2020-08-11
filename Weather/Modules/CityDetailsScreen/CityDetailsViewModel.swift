//
//  CityDetailsViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

protocol CityDetailsViewModel_View {
    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    func prepareCellModel(cityName: String) -> [CustomTempDegreeCellModel]
    func getCityData(cityName: String) -> Results<CitiesDBModel>?
    func getImageName(temp: Double) -> String
    var cellsModel : [CustomTempDegreeCellModel] { get set }
    var degreesList : Results<CitiesDBModel>? { get set }
}

class CityDetailsViewModel_Model: BaseViewModel_Model, CityDetailsViewModel_View {
    var changeHandler: ChangeHandler?
    var degreesList: Results<CitiesDBModel>?
    var cellsModel: [CustomTempDegreeCellModel]

    override init() {
        cellsModel = [CustomTempDegreeCellModel]()
        degreesList = nil
        super.init()
    }

    func prepareCellModel(cityName: String) -> [CustomTempDegreeCellModel] {
        degreesList = getCityData(cityName: cityName)
        guard degreesList != nil else {return cellsModel}

        for row in degreesList!{
            var model : CustomTempDegreeCellModel = CustomTempDegreeCellModel()
            let dateAndTime = (row.date)!
            let temp = row.temp
            let celsuisDegree = self.ConvertTempreture(temp: temp, type: self.getTempType(tempType: (row.tempType)!))
            model.currentTime = self.getTime(date: dateAndTime)
            model.todayDate = self.getDate(date: dateAndTime)
            model.temp = "\(celsuisDegree) °"
            model.iconImage = self.getImageName(temp: celsuisDegree)
            cellsModel.append(model)
        }
        self.changeHandler?()
        return cellsModel
    }
    func getCityData(cityName: String) -> Results<CitiesDBModel>? {
        let realm = try! Realm()
        let degreesList = realm.objects(CitiesDBModel.self).filter("cityName = '\(cityName)'").sorted(byKeyPath: "date", ascending: true)
        return degreesList
    }

    func getImageName(temp: Double) -> String {
        switch temp {
        case let temp where temp <= 22.5:
            return R.image.snowingIcon()!.accessibilityIdentifier!
        case let temp where temp <= 25.0 && temp > 22.5:
            return R.image.cloudyIcon()!.accessibilityIdentifier!
        case let temp where temp <= 27.5 && temp > 25.0:
            return R.image.rainyIcon()!.accessibilityIdentifier!
        case let temp where temp > 27.5:
            return R.image.sunnyIcon()!.accessibilityIdentifier!
        default:
            return "unkown"
        }
    }
}

