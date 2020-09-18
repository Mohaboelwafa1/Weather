//
//  TempConverter.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation

protocol TempConverterProtocol {
    static func convertTempreture(temp: Double , type: TempTypeEnumeration) -> Double
}

class TempConverter: TempConverterProtocol {

    static func convertTempreture(temp: Double, type: TempTypeEnumeration) -> Double {
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

}
