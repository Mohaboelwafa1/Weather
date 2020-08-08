//
//  SplashViewController.swift
//  Weather
//
//  Created by Mohammed hassan on 8/8/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController : UIViewController {

    @IBOutlet weak var launchScreenBGImage: UIImageView!
    var splashViewModel: SplashViewModel_View  = SplashViewModel_Model()


    override func viewDidLoad() {
        super.viewDidLoad()
        ShowIndicator()
        fetchWeatherData()
    }

    func fetchWeatherData() {
        DispatchQueue.global(qos: .background).async {
            self.splashViewModel.getCitiesList(completionHandler: {
                (result, statusCode, errorModel)in
                if statusCode == 200 {
                    self.dismiss(animated: false, completion: nil)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let cityListViewController = storyBoard.instantiateViewController(withIdentifier: "CitiesListViewController") as! CitiesListViewController
                    self.navigationController?.pushViewController(cityListViewController, animated: true)
                } else {
                    
                }
            })
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func ShowIndicator() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

}
