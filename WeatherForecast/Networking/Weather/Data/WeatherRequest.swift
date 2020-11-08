//
//  WeatherRequest.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import Foundation

struct WeatherRequest: Encodable {
    let city: String
    let units = "metric"

    enum CodingKeys: String, CodingKey {
        case city = "q"
        case units
    }
}
