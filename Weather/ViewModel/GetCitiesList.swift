//
//  GetCitiesList.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
protocol GetCitiesList {
    func requestData(completion: ([CitiesResponseModel]) -> Void)
}
