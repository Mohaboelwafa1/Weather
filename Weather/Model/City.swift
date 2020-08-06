//
//  City.swift
//  Weather
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
struct City : Codable {
    let name : String?
    let picture : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case picture = "picture"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }

}
