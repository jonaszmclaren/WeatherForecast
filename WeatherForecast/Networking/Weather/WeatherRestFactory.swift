//
//  WeatherRestFactory.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import Foundation

final class WeatherRestFactory {

    // MARK: - Init

    private init() {}

    // MARK: - Methods

    static func apiService() -> WeatherRestServiceProtocol {
        return WeatherRestService(restService: RestServiceFactory.restService())
    }
}
