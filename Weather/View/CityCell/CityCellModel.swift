//
//  CityCellModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

struct CityCellModel : Codable {

    var currentTime : String
    var cityName : String
    var tempreture : String
    var backGroundImage: String

    enum CodingKeys: String, CodingKey {
        case currentTime = "currentTime"
        case cityName = "cityName"
        case tempreture = "tempreture"
        case backGroundImage = "backGroundImage"
    }

    init() {
        currentTime = ""
        cityName = ""
        tempreture = ""
        backGroundImage = ""
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentTime = try values.decodeIfPresent(String.self, forKey: .currentTime)!
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)!
        tempreture = try values.decodeIfPresent(String.self, forKey: .tempreture)!
        backGroundImage = try values.decodeIfPresent(String.self, forKey: .backGroundImage)!
    }
}
