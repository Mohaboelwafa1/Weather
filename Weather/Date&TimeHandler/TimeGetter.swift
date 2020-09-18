//
//  TimeGetter.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation

protocol TimeGetterProtocol {
    static func getTime(time: String?) -> String
}

class TimeGetter: TimeGetterProtocol {
    static func getTime(time: String?) -> String {
        var dayNightMode = "am"
        let isoDate = time!
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
}
