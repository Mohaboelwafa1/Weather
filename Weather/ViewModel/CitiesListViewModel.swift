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
    // Get list of cities
    func getCitiesList(completionHandler: @escaping (
        _ userInfoResponseModel:Results<CitiesDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)

}

enum TempType: String{
    case Celsius = "C"
    case Kelvin = "K"
    case Fahrenheit = "F"
}

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


class CitiesListViewModel_Model: NSObject, CitiesListViewModel_View {

    var citiesResponseModel: [CitiesResponseModel]

    override init() {
        citiesResponseModel = [CitiesResponseModel]()
        super.init()
    }

    func getCitiesList(completionHandler: @escaping (Results<CitiesDBModel>?, Int, Error_Response_Model) -> Void) {
        APIManager().GetCitiesList(completionHandler: {
            (result, statusCode, errorModel) in

            let realm = try! Realm()

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

            let unRepeatedCitiesList = realm.objects(CitiesDBModel.self).distinct(by: ["cityName"])
            completionHandler(unRepeatedCitiesList, statusCode, errorModel)
        })
    }

}
