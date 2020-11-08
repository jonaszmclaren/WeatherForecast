//
//  DailyWeatherRouter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol DailyWeatherRoutingLogic {}

protocol DailyWeatherDataPassing {
    var dataStore: DailyWeatherDataStore? { get }
}

class DailyWeatherRouter: NSObject, DailyWeatherRoutingLogic, DailyWeatherDataPassing {
    
    // MARK: - Properties
    
    weak var viewController: DailyWeatherViewController?
    var dataStore: DailyWeatherDataStore?
    
    // MARK: - Initializer

    init(viewController: DailyWeatherViewController?, dataStore: DailyWeatherDataStore?) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}
