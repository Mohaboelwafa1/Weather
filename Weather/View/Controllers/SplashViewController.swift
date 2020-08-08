//
//  SplashViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Toast_Swift

class SplashViewController : UIViewController {

    @IBOutlet weak var launchScreenBGImage: UIImageView!
    var splashViewModel: SplashViewModel_View  = SplashViewModel_Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        if Utilities.shared.isItFirstLaunch() {
            fetchWeatherData()
        } else {
            goToCitiesListScreen()
        }
    }

    func fetchWeatherData() {
        if Utilities.shared.isConnectedToNetwork() {
            Utilities.shared.ShowIndicator(title: "", message: "Please wait ...", controller: self)
            DispatchQueue.global(qos: .background).async {
                self.splashViewModel.getCitiesList(completionHandler: {
                    (result, statusCode, errorModel)in
                    if statusCode == 200 {
                        self.goToCitiesListScreen()
                    }
                })
            }
        } else {
            let isUserTappedMessage = Utilities.shared.showConnectionError(
                view: self,
                title: "Connection error",
                duration: 1.0,
                message: "Make sure of connection. tap to retry",
                image: "CloudyIcon.png"
            )
            if isUserTappedMessage {
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
