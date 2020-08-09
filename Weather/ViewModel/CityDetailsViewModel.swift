//
//  CityDetailsViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

protocol CityDetailsViewModel_View {
    func prepareCellModel(cityName: String) -> [CustomTempDegreeCellModel]
    func getCityData(cityName: String) -> Results<CitiesDBModel>?
    func getImageName(degree: Double) -> String
    var cellsModel : [CustomTempDegreeCellModel] { get set }
    var degreesList : Results<CitiesDBModel>? { get set }
}

class CityDetailsViewModel_Model: BaseViewModel_Model, CityDetailsViewModel_View {
    var degreesList: Results<CitiesDBModel>?
    var cellsModel: [CustomTempDegreeCellModel]

    override init() {
        cellsModel = [CustomTempDegreeCellModel]()
        degreesList = nil
        super.init()
    }

    func prepareCellModel(cityName: String) -> [CustomTempDegreeCellModel] {
        degreesList = getCityData(cityName: cityName)
        for row in degreesList!{
            var model : CustomTempDegreeCellModel = CustomTempDegreeCellModel()
            let dateAndTime = (row.date)!
            let degree = row.temp
            let celsuisDegree = self.ConvertTempreture(temp: degree, type: (row.tempType)!)
            model.currentTime = self.getTime(date: dateAndTime)
            model.todayDate = self.getDate(date: dateAndTime)
            model.tempreture = "\(celsuisDegree) °"
            model.iconImage = self.getImageName(degree: celsuisDegree)
            cellsModel.append(model)
        }
        return cellsModel
    }
    func getCityData(cityName: String) -> Results<CitiesDBModel>? {
        let realm = try! Realm()
        let degreesList = realm.objects(CitiesDBModel.self).filter("cityName = '\(cityName)'").sorted(byKeyPath: "date", ascending: true)
        return degreesList
    }

    func getImageName(degree: Double) -> String {
        switch degree {
        case let degree where degree <= 22.5:
            return R.image.snowingIcon()!.accessibilityIdentifier!
        case let degree where degree <= 25.0 && degree > 22.5:
            return R.image.cloudyIcon()!.accessibilityIdentifier!
        case let degree where degree <= 27.5 && degree > 25.0:
            return R.image.rainyIcon()!.accessibilityIdentifier!
        case let degree where degree > 27.5:
            return R.image.sunnyIcon()!.accessibilityIdentifier!
        default:
            return"unkown"
        }
    }
}

