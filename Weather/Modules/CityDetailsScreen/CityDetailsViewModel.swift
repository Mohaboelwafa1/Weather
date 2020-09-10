//
//  CityDetailsViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

class CityDetailsViewModel: BaseViewModel, CityDetailsViewModel_Protocol {
    internal var changeHandler: ChangeHandler?
    internal var degreesList: Results<CitiesDBModel>?
    internal var cellsModel: [CustomTempDegreeCellModel]

    override init() {
        degreesList = nil
        cellsModel = [CustomTempDegreeCellModel]()
        super.init()
    }

    internal func prepareCellModel(cityName: String) -> [CustomTempDegreeCellModel] {
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

    internal func getCityData(cityName: String) -> Results<CitiesDBModel>? {
        let realm = try! Realm()
        let degreesList = realm.objects(CitiesDBModel.self).filter("cityName = '\(cityName)'").sorted(byKeyPath: "date", ascending: true)
        return degreesList
    }

    internal func getImageName(temp: Double) -> String {
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
            return R.image.unknownWeather()!.accessibilityIdentifier!
        }
    }
}

