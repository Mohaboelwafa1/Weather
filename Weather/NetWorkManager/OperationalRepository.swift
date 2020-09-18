//
//  OperationalRepository.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import Alamofire

protocol OperationalRepository {}

extension OperationalRepository {

    internal func excuteServerOperation(
        url : String,
        way: HTTPMethod,
        completionHandler: @escaping ( _ result: AnyObject, _ statusCode : Int, _ errormodel:AnyObject) -> Void
        ) -> Void {

        if Reachability.isConnectedToNetwork() == true {
            AF.request(url, method: way, encoding: JSONEncoding.default).responseJSON {
                response in
                switch response.result {
                case .success(_):
                    if response.data != nil {
                        completionHandler(response.data as AnyObject, response.response?.statusCode ?? 404 , response.data as AnyObject)
                    }
                case .failure(_): break
                }
            }
        } else {
        }
    }

}
