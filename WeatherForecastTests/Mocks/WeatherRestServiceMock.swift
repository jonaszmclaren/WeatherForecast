//
//  WeatherRestServiceMock.swift
//  WeatherForecastUnitTest
//
//  Created by Jonasz Baron on 08/11/2020.
//

import Foundation
@testable import WeatherForecast

class WeatherRestServiceMock: WeatherRestServiceProtocol {

    var success = true

    func getCurrentWeather(request: WeatherRequest, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) {
        if success {
            completion(.success(CurrentWeatherResponse.mockObject))
        } else {
            completion(.failure(WFError.unknown))
        }
    }

    func getDailyWeather(request: WeatherRequest, completion: @escaping (Result<DailyWeatherListResponse, Error>) -> Void) {
        if success {
            completion(.success(DailyWeatherListResponse.mockObject))
        } else {
            completion(.failure(WFError.unknown))
        }
    }
}
