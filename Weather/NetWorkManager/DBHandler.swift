//
//  DBHandler.swift
//  Weather
//
//  Created by Mohammed hassan on 9/10/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import RealmSwift

class DBHandler {
    func saveToDB(data: [CitiesResponseModel]) {
        let realm = try! Realm()

        try! realm.write {
            realm.deleteAll()
        }

        for city in data {
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
    }
}
