//
//  CitiesListViewModel_Protocol.swift
//  Weather
//
//  Created by Mohammed hassan on 9/10/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

protocol CitiesListViewModel_Protocol {
    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    var citiesResponseModel: [CitiesResponseModel] { get }
    var cellsModel : [CityCellModel] { get set }
    var citiesList : Results<CitiesDBModel>? { get set }
    var dbHandler: DBHandler { get }

    func prepareCellModel() -> [CityCellModel]
    func getCitiesListOffline() -> Results<CitiesDBModel>?
    func getCitiesList(completionHandler: @escaping (
        _ ResponseModel:Results<CitiesDBModel>?,
        _ statusCode : Int,
        _ error_Response_Model:Error_Response_Model
        ) -> Void)
}
