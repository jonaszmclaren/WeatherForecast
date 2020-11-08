//
//  WindResponse.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

struct WindResponse: Decodable {
    let speed: Double?
    let degrees: Int?

    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
    }
}
