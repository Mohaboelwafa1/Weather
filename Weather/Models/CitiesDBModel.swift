//
//  CitiesDBModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

class CitiesDBModel: Object {
    @objc dynamic var date: String?
    @objc dynamic var cityName: String?
    @objc dynamic var cityPicture: String?
    @objc dynamic var tempType: String?
    @objc dynamic var temp: Double = 0
}
