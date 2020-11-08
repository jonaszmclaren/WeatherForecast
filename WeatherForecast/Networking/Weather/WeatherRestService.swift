//
//  WeatherRestService.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import Foundation

protocol WeatherRestServiceProtocol {
    func getCurrentWeather(request: WeatherRequest, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void)
    func getDailyWeather(request: WeatherRequest, completion: @escaping (Result<DailyWeatherListResponse, Error>) -> Void)
}

struct WeatherRestService: WeatherRestServiceProtocol {

    // MARK: - Properties

    let restService: RestServiceProtocol

    // MARK: - Init

    init(restService: RestServiceProtocol) {
        self.restService = restService
    }

    // MARK: - Methods

    func getCurrentWeather(request: WeatherRequest, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) {
        restService.getObject(router: WeatherAPIRouter.currentWeather(request: request), completion: completion)
    }

    func getDailyWeather(request: WeatherRequest, completion: @escaping (Result<DailyWeatherListResponse, Error>) -> Void) {
        restService.getObject(router: WeatherAPIRouter.dailyWeather(request: request), completion: completion)
    }
}
