//
//  TempType.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation

protocol TempTypeProtocol {
    static func getTempType(tempType: String) -> TempTypeEnumeration
}

class TempType: TempTypeProtocol {

    static func getTempType(tempType: String) -> TempTypeEnumeration {
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

}
