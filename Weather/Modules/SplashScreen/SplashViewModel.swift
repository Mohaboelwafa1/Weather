//
//  SplashViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

class SplashViewModel: NSObject, SplashViewModel_Protocol {

    internal var changeHandler: ChangeHandler?
    internal let dbHandler: DBHandler
    init(dbHandler: DBHandler) {
        self.dbHandler = dbHandler
    }

    internal func getCitiesList(completionHandler: @escaping (Results<CitiesDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().GetCitiesList(completionHandler: {
            (result, statusCode, errorModel) in
            
            if result == nil {completionHandler(nil, statusCode, errorModel ?? Error_Response_Model())}

            self.dbHandler.saveToDB(data: result ?? [CitiesResponseModel()])

            let realm = try! Realm()
            let citiesList = realm.objects(CitiesDBModel.self)

            self.changeHandler?()
            completionHandler(citiesList, statusCode, errorModel ?? Error_Response_Model())
        })
    }

}
