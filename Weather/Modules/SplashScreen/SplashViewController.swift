//
//  SplashViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

class SplashViewController : UIViewController {

    @IBOutlet weak var launchScreenBGImage: UIImageView!
    var viewModel: SplashViewModel_View  = SplashViewModel_Model()

    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.changeHandler = { [weak self] in
            self?.goToCitiesListScreen()
        }

        if Utilities.shared.isItFirstLaunch() {
            fetchWeatherData()
        } else {
            goToCitiesListScreen()
        }
    }

    func fetchWeatherData() {
        if Utilities.shared.isConnectedToNetwork() {
            Utilities.shared.ShowIndicator(title: nil, message:  R.string.localizable.pleaseWait(), controller: self)
            DispatchQueue.global(qos: .background).async {
                self.viewModel.getCitiesList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        UserDefaults.standard.set(true, forKey: "launchedBefore")
                    }
                })
            }
        } else {
            UserDefaults.standard.set(false, forKey: "launchedBefore")
            Utilities.shared.showConnectionError(
                view: self,
                title: R.string.localizable.connectionError(),
                duration: 2.0,
                message: R.string.localizable.retryConnect(),
                image: R.image.cloudyIcon()
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.fetchWeatherData()
            }
        }
    }

    func goToCitiesListScreen() {
        self.dismiss(animated: false, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cityListViewController = storyBoard.instantiateViewController(withIdentifier: "CitiesListViewController") as! CitiesListViewController
        self.navigationController?.pushViewController(cityListViewController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
