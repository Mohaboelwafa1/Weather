//
//  SplashViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

protocol SplashViewModel_View {
    var citiesResponseModel: [CitiesResponseModel] { get }
    func getCitiesList(completionHandler: @escaping (
        _ ResponseModel:Results<CitiesDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)
}

class SplashViewModel_Model: NSObject, SplashViewModel_View {

    var citiesResponseModel: [CitiesResponseModel]

    override init() {
        citiesResponseModel = [CitiesResponseModel]()
        super.init()
    }

    func getCitiesList(completionHandler: @escaping (Results<CitiesDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().GetCitiesList(completionHandler: {
            (result, statusCode, errorModel) in
            
            if result == nil {completionHandler(nil, statusCode, errorModel ?? Error_Response_Model())}

            let realm = try! Realm()

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

            let citiesList = realm.objects(CitiesDBModel.self)
            completionHandler(citiesList, statusCode, errorModel ?? Error_Response_Model())
        })
    }
}
