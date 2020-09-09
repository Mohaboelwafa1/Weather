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
    @IBOutlet weak var backGroundImage: AsyncImageView!

    internal var cityName: String?
    private let viewModel = CityDetailsViewModel()
    private var cellsModel: [CustomTempDegreeCellModel] = [CustomTempDegreeCellModel]()

    // NOTE : Track if there is memory leak. If this is called so it is ok.
    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // NOTE : Get notified when there is some changes in the view model and update the UI
        viewModel.changeHandler = { [weak self] in
            self?.listOfCityDegrees.reloadData()
        }

        setupView()
        fetchData()
        addBackGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listOfCityDegrees.backgroundColor = .clear
        self.listOfCityDegrees.isOpaque = false;
    }

    func setupView() {
        if let cityname = cityName {
            cityNameLabel.text = cityname
        }
        listOfCityDegrees.register(CustomTempDegreeCell.self, forCellReuseIdentifier: "CustomTempDegreeCell")
        self.listOfCityDegrees.register(UINib(nibName: "CustomTempDegreeCell",bundle: nil), forCellReuseIdentifier: "CustomTempDegreeCell")
    }

    func fetchData(){
        guard cityName != nil else {return}
        cellsModel = viewModel.prepareCellModel(cityName: cityName!)
    }

    func addBackGesture() {
        let backMoveRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(swipeMade(_:)))
        backMoveRecognizer.direction = .right
        self.view.addGestureRecognizer(backMoveRecognizer)
    }

    // NOTE: Swipe right to back to the previous screen
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

