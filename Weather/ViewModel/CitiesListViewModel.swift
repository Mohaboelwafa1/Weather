//
//  CitiesListViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import RealmSwift

protocol CitiesListViewModel_View {

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

class CitiesListViewModel_Model: BaseViewModel_Model, CitiesListViewModel_View {

    var citiesResponseModel: [CitiesResponseModel]
    var cellsModel: [CityCellModel]
    var citiesList: Results<CitiesDBModel>?

    override init() {
        citiesResponseModel = [CitiesResponseModel]()
        cellsModel = [CityCellModel]()
        citiesList = nil
        super.init()
    }

    func prepareCellModel() -> [CityCellModel] {

        for row in self.citiesList! {
            var model : CityCellModel = CityCellModel()
            let dateAndTime = (row.date)!
            let degree = row.temp
            let celsuisDegree = self.ConvertTempreture(temp: degree, type: (row.tempType)!)

            model.cityName = row.cityName ?? "Loading ..."
            model.currentTime = self.getDate(date: dateAndTime)
            model.tempreture = "\(celsuisDegree)"
            model.backGroundImage = row.cityPicture ?? ""
            cellsModel.append(model)
        }

        return cellsModel
    }

    func getCitiesListOffline() -> Results<CitiesDBModel>? {
        let realm = try! Realm()
        citiesList = realm.objects(CitiesDBModel.self).distinct(by: ["cityName"]).sorted(byKeyPath: "cityName", ascending: true)
        return citiesList
    }

    func getCitiesList(completionHandler: @escaping (Results<CitiesDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().GetCitiesList(completionHandler: {
            (result, statusCode, errorModel) in

            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            for city in result {
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
            completionHandler(citiesList, statusCode, errorModel)
        })
    }

}
