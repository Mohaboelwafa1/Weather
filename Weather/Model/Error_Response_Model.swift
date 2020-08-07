//
//  Error_Response_Model.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
// ERROR RESPONSE MODEL //////////////////
struct Error_Response_Model : Codable {
    var code : String?
    var message : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
    }

    init(){
        code = "code"
        message = "Message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(code, forKey: "code")
        aCoder.encode(message, forKey: "message")
    }
}
