//
//  Utilities.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//
import Foundation
import SystemConfiguration

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

}
