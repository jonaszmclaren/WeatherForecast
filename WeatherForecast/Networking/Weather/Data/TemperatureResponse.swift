//
//  TemperatureResponse.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

struct TemperatureResponse: Decodable {
    let temperature: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}
