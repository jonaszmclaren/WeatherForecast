//
//  WeatherAPIRouter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import Foundation
import Alamofire

enum WeatherAPIRouter: APIRouter {
    case currentWeather(request: WeatherRequest)
    case dailyWeather(request: WeatherRequest)

    var path: String {
        switch self {
        case .currentWeather:
            return Constants.currentWeatherPath
        case .dailyWeather:
            return Constants.dailyWeatherPath
        }
    }

    var parameters: Parameters? {
        switch self {
        case .currentWeather(let request):
            return prepareParameters(object: request)
        case .dailyWeather(let request):
            return prepareParameters(object: request)
        }
    }
}
