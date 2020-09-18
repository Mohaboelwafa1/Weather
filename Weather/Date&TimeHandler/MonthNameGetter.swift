//
//  MonthNameGetter.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation

protocol MonthNameGetterProtocol {
    static func getMonthName(month:Int) -> String
}

class MonthNameGetter: MonthNameGetterProtocol {
    // NOTE: Return month name regarding its order
    static func getMonthName(month:Int) -> String {
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
