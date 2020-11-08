//
//  ForecastModels.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Forecast {

    enum Section: Int, CaseIterable {
        case currentWeather = 0
        case dailyWeather
    }
    
    // MARK: - Use cases
    
    enum GetCurrentWeather {
        struct Request {
            let city: String
        }
        
        enum Response {
            case success(CurrentWeatherResponse)
            case error(Error)
        }
        
        struct ViewModel {
            let name: String?
            let icon: String?
            let title: String?
            let temperature: String?
            let feelsLike: String?
        }
    }

    enum GetDailyWeather {
        struct Request {
            let city: String
        }

        enum Response {
            case success(DailyWeatherListResponse)
            case error(Error)
        }

        struct ViewModel {
            let days: [Day]

            struct Day {
                let dayName: String?
                let icon: String?
                let dayTemperature: String?
                let nightTemperature: String?
            }
        }
    }
}
