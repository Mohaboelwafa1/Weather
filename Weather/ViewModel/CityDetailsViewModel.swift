//
//  CityDetailsViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import RealmSwift

protocol CityDetailsViewModel_View {

    func getCityData(cityName: String) -> Results<CitiesDBModel>?
    func getDate(date: String?) -> String
    func getTime(date: String?) -> String
    func ConvertTempreture(temp: Double , type: String) -> Double
    func getImageName(degree: Double) -> String

}

class CityDetailsViewModel_Model: NSObject, CityDetailsViewModel_View {

    override init() {
        super.init()
    }

    func getCityData(cityName: String) -> Results<CitiesDBModel>? {
        let realm = try! Realm()
        let degreesList = realm.objects(CitiesDBModel.self).filter("cityName = '\(cityName)'").sorted(byKeyPath: "date", ascending: true)
        return degreesList
    }

    func getDate(date: String?) -> String {
        let isoDate = date!
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.formatOptions = .withFullDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let month = getMonthName(month: components.month!)
        return "\(components.day!) \(month)"
    }

    func getTime(date: String?) -> String {
        var dayNightMode = "am"
        let isoDate = date!
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.formatOptions = .withFullDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        if components.hour! >= 12 {
            dayNightMode = "pm"
        } else {
            dayNightMode = "am"
        }

        if components.hour! > 0 && components.hour! < 10 {
            return "0\(components.hour!):00 \(dayNightMode)"
        } else {
            return "\(components.hour!):00 \(dayNightMode)"
        }

    }

    func getMonthName(month:Int) -> String {
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Unkown"
        }
    }

    func getImageName(degree: Double) -> String {
        switch degree {
        case let degree where degree <= 22.5:
            return "SnowingIcon"
        case let degree where degree <= 25.0 && degree > 22.5:
            return "CloudyIcon"
        case let degree where degree <= 27.5 && degree > 25.0:
            return "RainyIcon"
        case let degree where degree > 27.5:
            return "SunnyIcon"
        default:
            return"unkown"
        }

    }

    func ConvertTempreture(temp: Double , type: String) -> Double {
        return Utilities.shared.ConvertTempreture(temp: temp, type: type)
    }
}

