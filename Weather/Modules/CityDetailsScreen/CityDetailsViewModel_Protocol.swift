//
//  CityDetailsViewModel_Protocol.swift
//  Weather
//
//  Created by Mohammed hassan on 9/10/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import RealmSwift

protocol CityDetailsViewModel_Protocol {
    typealias ChangeHandler = (() -> Void)
    var changeHandler: ChangeHandler? { get set }
    var degreesList : Results<CitiesDBModel>? { get set }
    var cellsModel : [CustomTempDegreeCellModel] { get set }

    func prepareCellModel(cityName: String) -> [CustomTempDegreeCellModel]
    func getCityData(cityName: String) -> Results<CitiesDBModel>?
}
