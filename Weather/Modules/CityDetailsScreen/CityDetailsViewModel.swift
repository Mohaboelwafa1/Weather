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
            let celsuisDegree = TempConverter.convertTempreture(temp: temp, type: TempType.getTempType(tempType: (row.tempType)!))
            model.currentTime = TimeGetter.getTime(time: dateAndTime)
            model.todayDate = DateGetter.getDate(date: dateAndTime)
            model.temp = "\(celsuisDegree) °"
            model.iconImage = GetImageNameForTemp.getImageName(temp: celsuisDegree)
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

}

