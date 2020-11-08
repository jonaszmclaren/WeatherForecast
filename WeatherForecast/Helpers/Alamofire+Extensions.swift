//
//  Alamofire+Extensions.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 30/10/2020.
//

import Foundation
import Alamofire

extension DataRequest {

    @discardableResult
    func log() -> DataRequest {
        return Logger.log(dataRequest: self)
    }
}
