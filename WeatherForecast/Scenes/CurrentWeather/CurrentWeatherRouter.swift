//
//  CurrentWeatherRouter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol CurrentWeatherRoutingLogic {}

protocol CurrentWeatherDataPassing {
    var dataStore: CurrentWeatherDataStore? { get }
}

class CurrentWeatherRouter: NSObject, CurrentWeatherRoutingLogic, CurrentWeatherDataPassing {
    
    // MARK: - Properties
    
    weak var viewController: CurrentWeatherViewController?
    var dataStore: CurrentWeatherDataStore?
    
    // MARK: - Initializer

    init(viewController: CurrentWeatherViewController?, dataStore: CurrentWeatherDataStore?) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}
