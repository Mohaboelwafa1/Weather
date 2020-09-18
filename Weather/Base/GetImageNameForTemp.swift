//
//  GetImageNameForTemp.swift
//  Weather
//
//  Created by Mohammed hassan on 9/18/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation

protocol GetImageNameForTempProtocol {
    static func getImageName(temp: Double) -> String
}

class GetImageNameForTemp: GetImageNameForTempProtocol {

    static func getImageName(temp: Double) -> String {
        switch temp {
        case let temp where temp <= 22.5:
            return R.image.snowingIcon()!.accessibilityIdentifier!
        case let temp where temp <= 25.0 && temp > 22.5:
            return R.image.cloudyIcon()!.accessibilityIdentifier!
        case let temp where temp <= 27.5 && temp > 25.0:
            return R.image.rainyIcon()!.accessibilityIdentifier!
        case let temp where temp > 27.5:
            return R.image.sunnyIcon()!.accessibilityIdentifier!
        default:
            return R.image.unknownWeather()!.accessibilityIdentifier!
        }
    }

}
