//
//  CurrentWeatherResponse.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    let name: String?
    let coordinates: CoordinatesDto?
    let weather: [WeatherDescriptionResponse]?
    let temperature: TemperatureResponse?
    let wind: WindResponse?

    enum CodingKeys: String, CodingKey {
        case name
        case coordinates = "coord"
        case weather
        case temperature = "main"
        case wind
    }
}
