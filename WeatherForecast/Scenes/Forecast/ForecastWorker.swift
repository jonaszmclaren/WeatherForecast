//
//  ForecastWorker.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ForecastWorkerLogic {
    func getCurrentWeather(forCity city: String, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void)
    func getDailyWeather(forCity city: String, completion: @escaping (Result<DailyWeatherListResponse, Error>) -> Void)
}

class ForecastWorker: ForecastWorkerLogic {
    
    // MARK: - Properties

    let weatherRestService: WeatherRestServiceProtocol

    // MARK: - Init
    
    init(weatherRestService: WeatherRestServiceProtocol) {
        self.weatherRestService = weatherRestService
    }

    // MARK: - Methods

    func getCurrentWeather(forCity city: String, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) {
        weatherRestService.getCurrentWeather(request: WeatherRequest(city: city), completion: completion)
    }

    func getDailyWeather(forCity city: String, completion: @escaping (Result<DailyWeatherListResponse, Error>) -> Void) {
        weatherRestService.getDailyWeather(request: WeatherRequest(city: city), completion: completion)
    }
}
