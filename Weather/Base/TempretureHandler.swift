//
//  TempretureHandler.swift
//  Weather
//
//  Created by Mohammed hassan on 9/10/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation

class TempretureHandler {
    // NOTE: Convert temperature gotten to celsius
    internal func ConvertTempreture(temp: Double, type: TempTypeEnumeration) -> Double {
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

    internal func getTempType(tempType: String) -> TempTypeEnumeration {
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
