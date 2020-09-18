//
//  SplashViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var launchScreenBGImage: AsyncImageView!
    private var viewModel: SplashViewModel!

    // NOTE : Track if there is memory leak. If this is called so it is ok.
    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel(dbHandler: DBHandler())
        // NOTE : Get notified when there is some changes in the view model and update the UI
        viewModel.changeHandler = { [weak self] in
            self?.goToCitiesListScreen()
        }

        if Utilities.shared.isItFirstLaunch() {
            fetchWeatherData()
        } else {
            goToCitiesListScreen()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func fetchWeatherData() {
        self.viewModel.getCitiesList(completionHandler: {
            (result, statusCode, errorModel)in
            UserDefaults.standard.set(true, forKey: Keys.launchedBefore.rawValue)
        })
    }

    func goToCitiesListScreen() {
        // NOTE : Hide the loader
        self.dismiss(animated: false, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cityListViewController = storyBoard.instantiateViewController(withIdentifier: "CitiesListViewController") as! CitiesListViewController
        self.navigationController?.pushViewController(cityListViewController, animated: true)
    }

/*
    func fetchWeatherData() {
        if Utilities.shared.isConnectedToNetwork() {
            Utilities.shared.ShowIndicator(title: nil, message:  R.string.localizable.pleaseWait(), controller: self)
            DispatchQueue.global(qos: .background).async {
                self.viewModel.getCitiesList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        UserDefaults.standard.set(true, forKey: Keys.launchedBefore.rawValue)
                    }
                })
            }
        } else {
            UserDefaults.standard.set(false, forKey: Keys.launchedBefore.rawValue)
            Utilities.shared.showConnectionError(
                view: self,
                title: R.string.localizable.connectionError(),
                duration: 2.0,
                message: R.string.localizable.retryConnect(),
                image: R.image.connectionError()
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.fetchWeatherData()
            }
        }
    }
    */

}
