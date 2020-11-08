//
//  DailyWeatherResponse.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

struct DailyWeatherListResponse: Decodable {
    let list: [DailyWeatherResponse]
}

struct DailyTemperatureResponse: Decodable {
    let day: Double?
    let night: Double?
    let min: Double?
    let max: Double?
}

struct DailyWeatherResponse: Decodable {
    let date: Date?
    let temperature: DailyTemperatureResponse?
    let sunrise: Date?
    let sunset: Date?
    let pressure: Int?
    let humidity: Int?
    let weather: [WeatherDescriptionResponse]?

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case sunrise
        case sunset
        case pressure
        case humidity
        case weather
    }
}
