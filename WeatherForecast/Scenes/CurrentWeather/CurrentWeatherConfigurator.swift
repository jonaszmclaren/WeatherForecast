//
//  CurrentWeatherConfigurator.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class CurrentWeatherConfigurator {
    
    // MARK: - Configuration
    
    func configure(viewController: CurrentWeatherViewController) {
        let presenter = CurrentWeatherPresenter(viewController: viewController)
        let worker = CurrentWeatherWorker()
        let interactor = CurrentWeatherInteractor(presenter: presenter, worker: worker)
        let router = CurrentWeatherRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
    }
}
