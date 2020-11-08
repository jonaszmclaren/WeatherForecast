//
//  ForecastInteractor.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ForecastBusinessLogic {
    func getCurrentWeather(request: Forecast.GetCurrentWeather.Request)
    func getDailyWeather(request: Forecast.GetDailyWeather.Request)
}

protocol ForecastDataStore {
    var options: [ForecastDataStoreOptionsKey: Any] { get set }
}

enum ForecastDataStoreOptionsKey: String {
    case currentWeather
    case dailyWeather
}

class ForecastInteractor: ForecastBusinessLogic, ForecastDataStore {
    
    // MARK: - Properties
    
    var presenter: ForecastPresentationLogic?
    let worker: ForecastWorkerLogic
    var options: [ForecastDataStoreOptionsKey: Any] = [:]

    // MARK: - Initializer

    init(presenter: ForecastPresentationLogic?, worker: ForecastWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods

    func getCurrentWeather(request: Forecast.GetCurrentWeather.Request) {
        worker.getCurrentWeather(forCity: request.city) { [weak self] result in
            switch result {
            case .success(let data):
                self?.options[.currentWeather] = data
                self?.presenter?.presentCurrentWeather(response: .success(data))
            case .failure(let error):
                self?.presenter?.presentCurrentWeather(response: .error(error))
            }
        }
    }

    func getDailyWeather(request: Forecast.GetDailyWeather.Request) {
        worker.getDailyWeather(forCity: request.city) { [weak self] result in
            switch result {
            case .success(let data):
                self?.options[.dailyWeather] = data
                self?.presenter?.presentDailyWeather(response: .success(data))
            case .failure(let error):
                self?.presenter?.presentDailyWeather(response: .error(error))
            }
        }
    }
}
