//
//  CustomTempDegreeCellModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

struct CustomTempDegreeCellModel: Codable {

    var todayDate : String
    var currentTime : String
    var temp : String
    var iconImage: String

    enum CodingKeys: String, CodingKey {
        case todayDate = "todayDate"
        case currentTime = "currentTime"
        case temp = "temp"
        case iconImage = "iconImage"
    }

    init() {
        todayDate = ""
        currentTime = ""
        temp = ""
        iconImage = ""
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        todayDate = try values.decodeIfPresent(String.self, forKey: .todayDate)!
        currentTime = try values.decodeIfPresent(String.self, forKey: .currentTime)!
        temp = try values.decodeIfPresent(String.self, forKey: .temp)!
        iconImage = try values.decodeIfPresent(String.self, forKey: .iconImage)!
    }
}
