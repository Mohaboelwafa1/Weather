//
//  CitiesResponseModel.swift
//  Weather
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation
struct CitiesResponseModel : Codable {
    let date : String?
    let city : City?
    let tempType : String?
    let temp : Double?

    enum CodingKeys: String, CodingKey {

        case date = "date"
        case city = "city"
        case tempType = "tempType"
        case temp = "temp"
    }

    init(){
        date = "date"
        city = City()
        tempType = "tempType"
        temp = 0.0
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        city = try values.decodeIfPresent(City.self, forKey: .city)
        tempType = try values.decodeIfPresent(String.self, forKey: .tempType)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(tempType, forKey: "tempType")
        aCoder.encode(temp, forKey: "temp")
    }



}
