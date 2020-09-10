//
//  Utilities.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import UIKit
import Toast_Swift

public class Utilities {

    private init() {}
    static let shared = Utilities()

    // NOTE: Show loading indicator
    func ShowIndicator(title: String?, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        controller.present(alert, animated: true, completion: nil)
    }

    func showConnectionError(view: UIViewController, title: String, duration: Double, message: String, image: UIImage?) {
        view.view!.makeToast(
            message,
            duration: duration,
            point: CGPoint(x: view.view.frame.size.width/2, y: view.view.frame.size.height/2),
            title: title,
            image: image) { didTap in
                if didTap {
                } else {
                }
        }
    }

    // NOTE: Check if the application ran before or not
    func isItFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: Keys.launchedBefore.rawValue)
        if launchedBefore  {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: Keys.launchedBefore.rawValue)
            return true
        }
    }

}
