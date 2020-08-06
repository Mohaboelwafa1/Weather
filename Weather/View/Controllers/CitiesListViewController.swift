//
//  CitiesListViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/6/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CitiesListViewController: UIViewController {

    @IBOutlet weak var listOfCitiesTable : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfCitiesTable.register(CustomCityCell.self, forCellReuseIdentifier: "CustomCityCell")
        listOfCitiesTable.register(UINib(nibName: "CustomCityCell",bundle: nil), forCellReuseIdentifier: "CustomCityCell")
    }



}
extension CitiesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCitiesTable!.dequeueReusableCell(withIdentifier: "CustomCityCell")! as! CustomCityCell
        var model : CityCellModel = CityCellModel()
        model.cityName = "Amsterdam"
        model.currentTime = "12.00"
        model.tempreture = "18 c"
        model.backGroundImage = "https://firebasestorage.googleapis.com/v0/b/mobile-assignment-server.appspot.com/o/budapest.jpg?alt=media&token=d2bff16e-6e11-433c-89ee-3481043636b5"
        (cell as! CustomCityCell).setModel(model: model)
        return cell

    }


}


extension CitiesListViewController : UITableViewDelegate {

}
