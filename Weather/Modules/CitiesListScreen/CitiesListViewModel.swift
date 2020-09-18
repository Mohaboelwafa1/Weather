//
//  CitiesListViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

class CitiesListViewModel: CitiesListViewModel_Protocol {

    internal var changeHandler: ChangeHandler?
    internal var citiesResponseModel: [CitiesResponseModel]
    internal var cellsModel: [CityCellModel]
    internal var citiesList: Results<CitiesDBModel>?
    internal let dbHandler: DBHandler

    init(dbHandler: DBHandler) {
        self.dbHandler = dbHandler
        citiesResponseModel = [CitiesResponseModel]()
        cellsModel = [CityCellModel]()
        citiesList = nil
    }

    internal func getCitiesListOffline() -> Results<CitiesDBModel>? {
        let realm = try! Realm()
        citiesList = realm.objects(CitiesDBModel.self).distinct(by: ["cityName"]).sorted(byKeyPath: "cityName", ascending: true)
        return citiesList
    }

    internal func getCitiesList(completionHandler: @escaping (Results<CitiesDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().GetCitiesList(completionHandler: {
            (result, statusCode, errorModel) in

            if result == nil {completionHandler(nil, statusCode, errorModel ?? Error_Response_Model())}
            self.dbHandler.saveToDB(data: result ?? [CitiesResponseModel()])
            let realm = try! Realm()
            let citiesList = realm.objects(CitiesDBModel.self).distinct(by: ["cityName"]).sorted(byKeyPath: "cityName", ascending: true)
            self.cellsModel = self.prepareCellModel()
            completionHandler(citiesList, statusCode, errorModel ?? Error_Response_Model())
        })
    }

    internal func prepareCellModel() -> [CityCellModel] {

        guard self.citiesList != nil else {return cellsModel}

        for row in self.citiesList! {
            var model : CityCellModel = CityCellModel()
            let dateAndTime = (row.date)!
            let temp = row.temp
            let celsuistemp = TempConverter.convertTempreture(temp: temp, type: TempType.getTempType(tempType: (row.tempType)!))

            model.cityName = row.cityName ?? R.string.localizable.loading()
            model.currentTime = DateGetter.getDate(date: dateAndTime)
            model.temp = "\(celsuistemp) °"
            model.backGroundImage = row.cityPicture ?? ""
            cellsModel.append(model)
        }
        self.changeHandler?()
        return cellsModel
    }

}
