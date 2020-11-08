//
//  ForecastConfigurator.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class ForecastConfigurator {
    
    // MARK: - Configuration
    
    func configure(viewController: ForecastViewController) {
        let presenter = ForecastPresenter(viewController: viewController)
        let worker = ForecastWorker(weatherRestService: WeatherRestFactory.apiService())
        let interactor = ForecastInteractor(presenter: presenter, worker: worker)
        let router = ForecastRouter(viewController: viewController, dataStore: interactor)

        viewController.interactor = interactor
        viewController.router = router
    }
}
