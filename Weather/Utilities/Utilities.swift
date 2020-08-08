//
//  Utilities.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation
import SystemConfiguration
import UIKit
import Toast_Swift

class Utilities
{
    private init() {}
    static let shared = Utilities()

    func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)

    }

    func ConvertTempreture(temp: Double , type: String) -> Double {
        switch type {
        case "C":
            return temp
        case "K":
            return  Double(round(100*(temp - 273.15))/100)
        case "F":
            return  Double(round(100*((temp - 32) / 1.8))/100)
        default:
            return temp
        }
    }

    func getDate(date: String?) -> String {
        let isoDate = date!
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.formatOptions = .withFullDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        return "\(components.day!)/\(components.month!)"
    }

    func ShowIndicator(title: String, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        controller.present(alert, animated: true, completion: nil)
    }

    func showConnectionError(view: UIViewController, title: String, duration: Double, message: String, image: String) ->Bool {
        var returnResult = false
        view.view!.makeToast(
        message,
        duration: duration,
        point: CGPoint(x: view.view.frame.size.width/2, y: view.view.frame.size.height/2),
        title: title,
        image: UIImage(named: "\(image)")) { didTap in
            if didTap {
                returnResult =  true
            } else {
                returnResult = false
            }
        }

        return returnResult
    }

    func isItFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            return true
        }
    }


}
