//
//  SplashViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

protocol SplashViewModel_Protocol {

    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    func getCitiesList(completionHandler: @escaping (
        _ ResponseModel:Results<CitiesDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)

}

class SplashViewModel: NSObject, SplashViewModel_Protocol {

    internal var changeHandler: ChangeHandler?

    override init() {
        super.init()
    }

    internal func getCitiesList(completionHandler: @escaping (Results<CitiesDBModel>?, Int, Error_Response_Model) -> Void) {
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
            self.changeHandler?()
            completionHandler(citiesList, statusCode, errorModel ?? Error_Response_Model())
        })
    }

}
