//
//  BaseViewModel_Protocol.swift
//  Weather
//
//  Created by Mohammed hassan on 9/10/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

protocol BaseViewModel_Protocol {
    func getDate(date: String?) -> String
    func getTime(date: String?) -> String
    func ConvertTempreture(temp: Double , type: TempTypeEnumeration) -> Double
    func getMonthName(month:Int) -> String
}
