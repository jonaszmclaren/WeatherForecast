//
//  WFDecoder.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

class WFDecoder: JSONDecoder {

    override init() {
        super.init()

        dateDecodingStrategy = .secondsSince1970
    }
}
