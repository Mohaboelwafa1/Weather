//
//  CityDetailsViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CityDetailsViewController: UIViewController {

    var cityName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let unRepeatedCitiesList = realm.objects(CitiesDBModel.self).filter("cityName = '\(cityName!)'").sorted(byKeyPath: "date", ascending: true)
    }

}
