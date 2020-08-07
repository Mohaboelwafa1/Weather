//
//  BaseApi.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit

struct BaseApi {
    // THE REAL SERVER
    static let mainPath = "https://us-central1-mobile-assignment-server.cloudfunctions.net"
}

enum EndPoint {
    case citiesList
    var path:String
    {
        switch self {
        // GET
        case .citiesList:
            return "/weather"
        }
    }
}
