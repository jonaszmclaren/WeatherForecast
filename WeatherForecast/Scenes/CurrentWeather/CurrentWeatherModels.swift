//
//  CurrentWeatherModels.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import CoreLocation

enum CurrentWeather {
    
    // MARK: - Use cases
    
    enum GetCurrentWeather {
        enum Response {
            case success(CurrentWeatherResponse)
            case error(Error)
        }

        struct ViewModel {
            let name: String?
            let icon: String?
            let description: String?
            let temperature: String?
            let feelsLike: String?
            let tempMin: String?
            let tempMax: String?
            let pressure: String?
            let humidity: String?
            let windSpeed: String?
            let windDegrees: String?
            let coordinates: CLLocationCoordinate2D?
        }
    }
}
