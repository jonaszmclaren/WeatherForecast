//
//  DailyWeatherPresenter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DailyWeatherPresentationLogic {
    func presentWeather(response: DailyWeather.GetWeather.Response)
}

class DailyWeatherPresenter: DailyWeatherPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: DailyWeatherDisplayLogic?
    
    // MARK: - Initializers

    init(viewController: DailyWeatherDisplayLogic?) {
        self.viewController = viewController
    }
    
    // MARK: - Methods

    func presentWeather(response: DailyWeather.GetWeather.Response) {
        switch response {
        case .success(let weather):
            let dayTemperature = NumberFormattingHelper.prepareTextWithFormat(fromDouble: weather.temperature?.day, inText: "Night tempearture: %@°C")
            let nightTemperature = NumberFormattingHelper.prepareTextWithFormat(fromDouble: weather.temperature?.night, inText: "Day temperature: %@°C")
            let tempMin = NumberFormattingHelper.prepareTextWithFormat(fromDouble: weather.temperature?.min, inText: "Minimum temperature: %@°C")
            let tempMax = NumberFormattingHelper.prepareTextWithFormat(fromDouble: weather.temperature?.max, inText: "Maximum temperature: %@°C")
            let sunrise = "Sunrise: " + (WFDateFormatter.stringLocal(from: weather.sunrise, dateStyle: .none, timeStyle: .medium) ?? "-")
            let sunset = "Sunset: " + (WFDateFormatter.stringLocal(from: weather.sunset, dateStyle: .none, timeStyle: .short) ?? "-")
            let pressure = NumberFormattingHelper.prepareTextWithFormat(fromInt: weather.pressure, inText: "Pressure: %@ hPa")
            let humidity = NumberFormattingHelper.prepareTextWithFormat(fromInt: weather.humidity, inText: "Humidity: %@%")

            viewController?.displayWeather(viewModel: DailyWeather.GetWeather.ViewModel(icon: weather.weather?.first?.icon, day: weather.date?.weekday, description: weather.weather?.first?.description, dayTemperature: dayTemperature, nightTemperature: nightTemperature, minTemperature: tempMin, maxTemperature: tempMax, sunrise: sunrise, sunset: sunset, pressure: pressure, humidity: humidity))
        case .error(let error):
            viewController?.displayError(error)
        }
    }
}
