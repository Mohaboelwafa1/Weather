//
//  CitiesListViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

protocol CitiesListViewModel_Protocol {

    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    var citiesResponseModel: [CitiesResponseModel] { get }
    var cellsModel : [CityCellModel] { get set }
    var citiesList : Results<CitiesDBModel>? { get set }

    func prepareCellModel() -> [CityCellModel]
    func getCitiesListOffline() -> Results<CitiesDBModel>?
    func getCitiesList(completionHandler: @escaping (
        _ ResponseModel:Results<CitiesDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)

}

class CitiesListViewModel: BaseViewModel, CitiesListViewModel_Protocol {

    internal var changeHandler: ChangeHandler?
    internal var citiesResponseModel: [CitiesResponseModel]
    internal var cellsModel: [CityCellModel]
    internal var citiesList: Results<CitiesDBModel>?

    override init() {
        citiesResponseModel = [CitiesResponseModel]()
        cellsModel = [CityCellModel]()
        citiesList = nil
        super.init()
    }

    internal func prepareCellModel() -> [CityCellModel] {

        guard self.citiesList != nil else {return cellsModel}

        for row in self.citiesList! {
            var model : CityCellModel = CityCellModel()
            let dateAndTime = (row.date)!
            let temp = row.temp
            let celsuistemp = self.ConvertTempreture(temp: temp, type: self.getTempType(tempType: (row.tempType)!))

            model.cityName = row.cityName ?? R.string.localizable.loading()
            model.currentTime = self.getDate(date: dateAndTime)
            model.temp = "\(celsuistemp) °"
            model.backGroundImage = row.cityPicture ?? ""
            cellsModel.append(model)
        }
        self.changeHandler?()
        return cellsModel
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

            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }

                for city in result! {
                    let cityModel = CitiesDBModel()
                    cityModel.date = city.date
                    cityModel.cityName = city.city?.name
                    cityModel.cityPicture = city.city?.picture
                    cityModel.tempType = city.tempType
                    cityModel.temp = city.temp ?? 0
                    try! realm.write {
                        realm.add(cityModel)
                    }
                }

            let citiesList = realm.objects(CitiesDBModel.self).distinct(by: ["cityName"]).sorted(byKeyPath: "cityName", ascending: true)
            self.cellsModel = self.prepareCellModel()
            completionHandler(citiesList, statusCode, errorModel ?? Error_Response_Model())
        })
    }

}
