//
//  BaseViewModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseViewModel_Protocol {
    func getDate(date: String?) -> String
    func getTime(date: String?) -> String
    func ConvertTempreture(temp: Double , type: TempTypeEnumeration) -> Double
    func getMonthName(month:Int) -> String
}

class BaseViewModel: NSObject, BaseViewModel_Protocol {

    override init() {
        super.init()
    }

    func ConvertTempreture(temp: Double, type: TempTypeEnumeration) -> Double {
        switch type {
        case .CELSIUS:
            return temp
        case .KELVIN:
            return  Double(round(100*(temp - 273.15))/100)
        case .FAHRENHEIT:
            return  Double(round(100*((temp - 32) / 1.8))/100)
        case .Unknown:
            return temp
        }
    }

    func getTempType(tempType: String) -> TempTypeEnumeration {
        switch tempType {
        case "C":
            return .CELSIUS
        case "K":
            return .KELVIN
        case "F":
            return .FAHRENHEIT
        default:
            return .Unknown

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
            return R.string.localizable.january()
        case 2:
            return R.string.localizable.february()
        case 3:
            return R.string.localizable.march()
        case 4:
            return R.string.localizable.april()
        case 5:
            return R.string.localizable.may()
        case 6:
            return R.string.localizable.june()
        case 7:
            return R.string.localizable.july()
        case 8:
            return R.string.localizable.august()
        case 9:
            return R.string.localizable.september()
        case 10:
            return R.string.localizable.october()
        case 11:
            return R.string.localizable.november()
        case 12:
            return R.string.localizable.december()
        default:
            return R.string.localizable.unkown()
        }
    }

}
