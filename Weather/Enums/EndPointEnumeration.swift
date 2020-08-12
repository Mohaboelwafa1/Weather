//
//  EndPointEnumeration.swift
//  Weather
//
//  Created by Mohammed hassan on 8/11/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//  List of End points names

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
