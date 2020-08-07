//
//  CitiesListViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
protocol CitiesListViewModel_View {

    var citiesResponseModel: [CitiesResponseModel] { get }
    // Get list of cities
    func getCitiesList(completionHandler: @escaping (
        _ userInfoResponseModel:[CitiesResponseModel],
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)

}


class CitiesListViewModel_Model: NSObject, CitiesListViewModel_View {

    var citiesResponseModel: [CitiesResponseModel]

    override init() {
        citiesResponseModel = [CitiesResponseModel]()
        super.init()
    }

    func getCitiesList(completionHandler: @escaping ([CitiesResponseModel], Int, Error_Response_Model) -> Void) {
           APIManager().GetCitiesList(completionHandler: {
               (result, statusCode, errorModel) in
               completionHandler(result, statusCode, errorModel)
           })
       }
}
