//
//  CurrentWeatherPresenter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import CoreLocation

protocol CurrentWeatherPresentationLogic {
    func presentCurrentWeather(response: CurrentWeather.GetCurrentWeather.Response)
}

class CurrentWeatherPresenter: CurrentWeatherPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: CurrentWeatherDisplayLogic?
    
    // MARK: - Initializers

    init(viewController: CurrentWeatherDisplayLogic?) {
        self.viewController = viewController
    }
    
    // MARK: - Methods

    func presentCurrentWeather(response: CurrentWeather.GetCurrentWeather.Response) {
        switch response {
        case .success(let currentWeather):
            let weather = currentWeather.weather?.first
            let currentTemperature = NumberFormattingHelper.prepareTextWithFormat(fromDouble: currentWeather.temperature?.temperature, inText: "Tempearture: %@°C")
            let feelsLike = NumberFormattingHelper.prepareTextWithFormat(fromDouble: currentWeather.temperature?.feelsLike, inText: "Feels like: %@°C")
            let tempMin = NumberFormattingHelper.prepareTextWithFormat(fromDouble: currentWeather.temperature?.tempMin, inText: "Minimum temperature: %@°C")
            let tempMax = NumberFormattingHelper.prepareTextWithFormat(fromDouble: currentWeather.temperature?.tempMax, inText: "Maximum temperature: %@°C")
            let pressure = NumberFormattingHelper.prepareTextWithFormat(fromInt: currentWeather.temperature?.pressure, inText: "Pressure: %@ hPa")
            let humidity = NumberFormattingHelper.prepareTextWithFormat(fromInt: currentWeather.temperature?.humidity, inText: "Humidity: %@%")
            let windSpeed = NumberFormattingHelper.prepareTextWithFormat(fromDouble: currentWeather.wind?.speed, inText: "Wind speed: %@ m/s")
            let windDegrees = NumberFormattingHelper.prepareTextWithFormat(fromInt: currentWeather.wind?.degrees, inText: "Wind direction: %@°")
            var coordinates: CLLocationCoordinate2D?

            if let latitude = currentWeather.coordinates?.latitude, let longitude = currentWeather.coordinates?.longitude {
                coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }

            viewController?.displayCurrentWeather(viewModel: CurrentWeather.GetCurrentWeather.ViewModel(name: currentWeather.name, icon: weather?.icon, description: weather?.description, temperature: currentTemperature, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity, windSpeed: windSpeed, windDegrees: windDegrees, coordinates: coordinates))
        case .error(let error):
            viewController?.displayError(error)
        }
    }
}
