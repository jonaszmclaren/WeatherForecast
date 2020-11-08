//
//  DailyWeatherModels.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum DailyWeather {
    
    // MARK: - Use cases
    
    enum GetWeather {
        enum Response {
            case success(DailyWeatherResponse)
            case error(Error)
        }
        
        struct ViewModel {
            let icon: String?
            let day: String?
            let description: String?
            let dayTemperature: String?
            let nightTemperature: String?
            let minTemperature: String?
            let maxTemperature: String?
            let sunrise: String?
            let sunset: String?
            let pressure: String?
            let humidity: String?
        }
    }
}
