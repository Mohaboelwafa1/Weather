//
//  OperationalRepository.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol OperationalRepository {}

extension OperationalRepository {

    func excuteServerOperation(url : String, way: HTTPMethod, completionHandler: @escaping ( _ result: AnyObject, _ statusCode : Int, _ errormodel:AnyObject) -> Void) -> Void{

        if Utilities.shared.isConnectedToNetwork() == true {
            AF.request(url, method: way, encoding: JSONEncoding.default).responseJSON {
                response in
                switch response.result {
                case .success(_):
                    if let json = response.data {
                        print("=====\(json)")
                        completionHandler(response.data as AnyObject, (response.response?.statusCode)! , response.data as AnyObject)
                    }
                case .failure(_): break
                }
            }
        } else {
        }
    }
}
