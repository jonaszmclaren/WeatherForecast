//
//  ForecastRouter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ForecastRoutingLogic {
    func routeToCurrentWeather()
    func routeToDailyWeather(index: Int)
}

protocol ForecastDataPassing {
    var dataStore: ForecastDataStore? { get }
}

class ForecastRouter: NSObject, ForecastRoutingLogic, ForecastDataPassing {
    
    // MARK: - Properties
    
    weak var viewController: ForecastViewController?
    var dataStore: ForecastDataStore?
    
    // MARK: - Initializer

    init(viewController: ForecastViewController?, dataStore: ForecastDataStore?) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: - Methods

    func routeToCurrentWeather() {
        guard let destination = Scene.currentWeather.viewController as? CurrentWeatherViewController, var destinationDS = destination.router?.dataStore else {
            return
        }

        viewController?.navigationController?.pushViewController(destination, animated: true)
        passDataToCurrentWeather(source: dataStore, destination: &destinationDS)
    }

    func routeToDailyWeather(index: Int) {
        guard let destination = Scene.dailyWeather.viewController as? DailyWeatherViewController, var destinationDS = destination.router?.dataStore else {
            return
        }

        viewController?.navigationController?.pushViewController(destination, animated: true)
        passDataToDailyWeather(source: dataStore, destination: &destinationDS, index: index)
    }

    // MARK: - Passing data
    
    func passDataToCurrentWeather(source: ForecastDataStore?, destination: inout CurrentWeatherDataStore) {
        destination.options[.currentWeather] = source?.options[.currentWeather]
    }

    func passDataToDailyWeather(source: ForecastDataStore?, destination: inout DailyWeatherDataStore, index: Int) {
        if let list = (source?.options[.dailyWeather] as? DailyWeatherListResponse)?.list, list.indices.contains(index) {
            destination.options[.weather] = list[index]
        }
    }
}
