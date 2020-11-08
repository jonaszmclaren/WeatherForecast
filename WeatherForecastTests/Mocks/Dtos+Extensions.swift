//
//  Dtos+Extensions.swift
//  WeatherForecastUnitTest
//
//  Created by Jonasz Baron on 08/11/2020.
//

import Foundation
@testable import WeatherForecast

extension CurrentWeatherResponse {

    static var mockObject: CurrentWeatherResponse {
        CurrentWeatherResponse(name: "name", coordinates: CoordinatesDto(longitude: 12.0, latitude: 32.0), weather: [WeatherDescriptionResponse(main: "main", description: "desc", icon: nil)], temperature: TemperatureResponse(temperature: 12.0, feelsLike: 15.0, tempMin: 1.0, tempMax: 15.0, pressure: 123, humidity: 321), wind: WindResponse(speed: 12.0, degrees: 321))
    }
}

extension DailyWeatherListResponse {

    static var mockObject: DailyWeatherListResponse {
        DailyWeatherListResponse(list: [DailyWeatherResponse.mockObject])
    }
}

extension DailyWeatherResponse {

    static var mockObject: DailyWeatherResponse {
        DailyWeatherResponse(date: Date(), temperature: DailyTemperatureResponse(day: 12.0, night: 12.0, min: 12.0, max: 15.0), sunrise: Date(), sunset: Date(), pressure: 123, humidity: 321, weather: [WeatherDescriptionResponse(main: "main", description: "desc", icon: nil)])
    }
}
