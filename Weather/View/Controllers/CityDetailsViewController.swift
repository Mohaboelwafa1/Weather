//
//  CityDetailsViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {

    @IBOutlet weak var listOfCityDegrees : UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    var cityName: String?
    var cityDetailsViewModel: CityDetailsViewModel_View  = CityDetailsViewModel_Model()
    var cellsModel: [CustomTempDegreeCellModel] = [CustomTempDegreeCellModel]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listOfCityDegrees.backgroundColor = .clear
        self.listOfCityDegrees.isOpaque = false;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
        addBackGesture()
    }

    func setupView() {
        if cityName != nil {cityNameLabel.text = cityName!}
        listOfCityDegrees.register(CustomTempDegreeCell.self, forCellReuseIdentifier: "CustomTempDegreeCell")
        self.listOfCityDegrees.register(UINib(nibName: "CustomTempDegreeCell",bundle: nil), forCellReuseIdentifier: "CustomTempDegreeCell")
        self.backGroundImage.image = R.image.nightBG()
    }

    func fetchData(){
        guard cityName != nil else {return}
        cellsModel = cityDetailsViewModel.prepareCellModel(cityName: cityName!)
    }

    func addBackGesture() {
        let backMoveRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(swipeMade(_:)))
        backMoveRecognizer.direction = .right
        self.view.addGestureRecognizer(backMoveRecognizer)
    }

    @IBAction func swipeMade(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

extension CityDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.listOfCityDegrees!.dequeueReusableCell(withIdentifier: "CustomTempDegreeCell")! as! CustomTempDegreeCell
        (cell as! CustomTempDegreeCell).setModel(model: cellsModel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CityDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

