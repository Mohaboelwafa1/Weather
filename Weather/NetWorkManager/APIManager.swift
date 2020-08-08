//
//  APIManager.swift
//  Weather
//
//  Created by Mohammed hassan on 8/7/20.
//  Copyright © 2020 Mohammed hassan. All rights reserved.
//

import SwiftyJSON

class APIManager: NSObject, OperationalRepository {
    func GetCitiesList(completionHandler: @escaping (_ result:[CitiesResponseModel], _ statusCode : Int, _ error_Response_Model:Error_Response_Model) -> Void) {
        let Newurl = BaseApi.mainPath + "\(EndPoint.citiesList.path)"
        excuteServerOperation(url: Newurl, way: .get, completionHandler: { (result, statusCode, errorModel ) in
            do{
                let jsonDecoder = JSONDecoder()
                var responseModel : [CitiesResponseModel]!
                var errorModel : Error_Response_Model!
                if(statusCode == 200){
                    responseModel = try jsonDecoder.decode([CitiesResponseModel].self, from: result as! Data)
                    errorModel = Error_Response_Model.init()
                } else {
                    responseModel = [CitiesResponseModel].init()
                    errorModel = Error_Response_Model.init()
                }
                completionHandler(responseModel, statusCode, errorModel)
            }
            catch{}
        } )
    }
}

