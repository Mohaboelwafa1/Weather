//
//  CustomTempDegreeCellModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation

struct CustomTempDegreeCellModel : Codable {

    var todayDate : String
    var currentTime : String
    var tempreture : String
    var iconImage: String

    enum CodingKeys: String, CodingKey {
        case todayDate = "todayDate"
        case currentTime = "currentTime"
        case tempreture = "tempreture"
        case iconImage = "iconImage"
    }

    init() {
        todayDate = ""
        currentTime = ""
        tempreture = ""
        iconImage = ""
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        todayDate = try values.decodeIfPresent(String.self, forKey: .todayDate)!
        currentTime = try values.decodeIfPresent(String.self, forKey: .currentTime)!
        tempreture = try values.decodeIfPresent(String.self, forKey: .tempreture)!
        iconImage = try values.decodeIfPresent(String.self, forKey: .iconImage)!
    }
}
