//
//  CurrentWeatherInteractor.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CurrentWeatherBusinessLogic {
    func getCurrentWeather()
}

protocol CurrentWeatherDataStore {
    var options: [CurrentWeatherDataStoreOptionsKey: Any] { get set }
}

enum CurrentWeatherDataStoreOptionsKey: String {
    case currentWeather
}

class CurrentWeatherInteractor: CurrentWeatherBusinessLogic, CurrentWeatherDataStore {
    
    // MARK: - Properties
    
    var presenter: CurrentWeatherPresentationLogic?
    let worker: CurrentWeatherWorkerLogic
    var options: [CurrentWeatherDataStoreOptionsKey: Any] = [:]
    
    // MARK: - Initializer

    init(presenter: CurrentWeatherPresentationLogic?, worker: CurrentWeatherWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods

    func getCurrentWeather() {
        guard let currentWeather = options[.currentWeather] as? CurrentWeatherResponse else {
            presenter?.presentCurrentWeather(response: .error(WFError.unknown))
            return
        }

        presenter?.presentCurrentWeather(response: .success(currentWeather))
    }
}
