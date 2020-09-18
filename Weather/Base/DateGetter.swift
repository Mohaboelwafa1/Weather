//
//  DateGetter.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation

protocol DateGetterProtocol {
    static func getDate(date: String?) -> String
}

class DateGetter: DateGetterProtocol {

    static func getDate(date: String?) -> String {
        let isoDate = date!
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.formatOptions = .withFullDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let month = MonthNameGetter.getMonthName(month: components.month!)
        return "\(components.day!) \(month)"
    }

}
