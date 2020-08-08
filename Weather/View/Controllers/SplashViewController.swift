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

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            // your code here
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let cityListViewController = storyBoard.instantiateViewController(withIdentifier: "CitiesListViewController") as! CitiesListViewController
            self.navigationController?.pushViewController(cityListViewController, animated: true)
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
    
}
