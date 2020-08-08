//
//  BaseViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseViewModel_View {
    func getDate(date: String?) -> String
    func getTime(date: String?) -> String
    func ConvertTempreture(temp: Double , type: String) -> Double
    func getMonthName(month:Int) -> String
}

class BaseViewModel_Model: NSObject, BaseViewModel_View {

    override init() {
        super.init()
    }

    func ConvertTempreture(temp: Double, type: String) -> Double {
        switch type {
        case "C":
            return temp
        case "K":
            return  Double(round(100*(temp - 273.15))/100)
        case "F":
            return  Double(round(100*((temp - 32) / 1.8))/100)
        default:
            return temp
        }
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

}
