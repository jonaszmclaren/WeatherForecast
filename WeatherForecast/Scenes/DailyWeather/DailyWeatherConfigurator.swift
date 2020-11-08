//
//  DailyWeatherConfigurator.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class DailyWeatherConfigurator {
    
    // MARK: - Configuration
    
    func configure(viewController: DailyWeatherViewController) {
        let presenter = DailyWeatherPresenter(viewController: viewController)
        let worker = DailyWeatherWorker()
        let interactor = DailyWeatherInteractor(presenter: presenter, worker: worker)
        let router = DailyWeatherRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
    }
}
