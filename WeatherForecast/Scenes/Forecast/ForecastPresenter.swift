//
//  ForecastPresenter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ForecastPresentationLogic {
    func presentCurrentWeather(response: Forecast.GetCurrentWeather.Response)
    func presentDailyWeather(response: Forecast.GetDailyWeather.Response)
}

class ForecastPresenter: ForecastPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: ForecastDisplayLogic?
    
    // MARK: - Initializers

    init(viewController: ForecastDisplayLogic?) {
        self.viewController = viewController
    }
    
    // MARK: - Methods

    func presentCurrentWeather(response: Forecast.GetCurrentWeather.Response) {
        switch response {
        case .success(let currentWeather):
            let weather = currentWeather.weather?.first
            var currentTemperature = ""
            var feelsLike = ""

            if let temperature = currentWeather.temperature?.temperature {
                currentTemperature = "Tempearture: " + temperature.toInt.stringValue + "°C"
            } else {
                currentTemperature = "-"
            }

            if let temperature = currentWeather.temperature?.feelsLike {
                feelsLike = "Feels like: " + temperature.toInt.stringValue + "°C"
            } else {
                currentTemperature = "-"
            }

            viewController?.displayCurrentWeather(viewModel: Forecast.GetCurrentWeather.ViewModel(name: currentWeather.name, icon: weather?.icon, title: weather?.main, temperature: currentTemperature, feelsLike: feelsLike))
        case .error(let error):
            viewController?.displayError(error)
        }
    }

    func presentDailyWeather(response: Forecast.GetDailyWeather.Response) {
        switch response {
        case .success(let dailyWeather):
            let days = dailyWeather.list.map { Forecast.GetDailyWeather.ViewModel.Day(dayName: $0.date?.weekday, icon: $0.weather?.first?.icon, dayTemperature: $0.temperature?.day?.toInt.stringValue, nightTemperature: $0.temperature?.night?.toInt.stringValue) }

            viewController?.displayDailyWeather(viewModel: Forecast.GetDailyWeather.ViewModel(days: days))
        case .error(let error):
            viewController?.displayError(error)
        }
    }
}
