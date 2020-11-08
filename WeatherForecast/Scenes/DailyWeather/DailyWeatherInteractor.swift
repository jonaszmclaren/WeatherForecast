//
//  DailyWeatherInteractor.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 06/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DailyWeatherBusinessLogic {
    func getWeather()
}

protocol DailyWeatherDataStore {
    var options: [DailyWeatherDataStoreOptionsKey: Any] { get set }
}

enum DailyWeatherDataStoreOptionsKey: String {
    case weather
}

class DailyWeatherInteractor: DailyWeatherBusinessLogic, DailyWeatherDataStore {
    
    // MARK: - Properties
    
    var presenter: DailyWeatherPresentationLogic?
    let worker: DailyWeatherWorkerLogic
    var options: [DailyWeatherDataStoreOptionsKey: Any] = [:]
    
    // MARK: - Initializer

    init(presenter: DailyWeatherPresentationLogic?, worker: DailyWeatherWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods

    func getWeather() {
        guard let weather = options[.weather] as? DailyWeatherResponse else {
            presenter?.presentWeather(response: .error(WFError.unknown))
            return
        }

        presenter?.presentWeather(response: .success(weather))
    }
}
