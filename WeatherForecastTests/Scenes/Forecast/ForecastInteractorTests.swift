//
//  ForecastInteractorTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class ForecastInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("ForecastInteractor") {
            
            // MARK: - Properties
            
            var sut: ForecastInteractor!
            var presenterSpy: ForecastPresentationLogicSpy!
            var workerMock: ForecastWorkerLogicMock!
            
            // MARK: - Setup
            
            beforeEach {
                presenterSpy = ForecastPresentationLogicSpy()
                workerMock = ForecastWorkerLogicMock()
                sut = ForecastInteractor(presenter: presenterSpy, worker: workerMock)
            }
            
            // MARK: - Tests
            
            describe("getCurrentWeather") {
                context("when it's called and succeeds") {
                    it("stores data and calls presenter with result") {
                        sut.getCurrentWeather(request: Forecast.GetCurrentWeather.Request(city: "Warsaw"))

                        expect(sut.options[.currentWeather]).toEventuallyNot(beNil())
                        expect(presenterSpy.presentCurrentWeatherSuccess).toEventually(beTrue())
                    }
                }

                context("when it's called and weather is not present") {
                    it("calls presenter with error") {
                        workerMock.success = false

                        sut.getCurrentWeather(request: Forecast.GetCurrentWeather.Request(city: "Warsaw"))

                        expect(presenterSpy.presentCurrentWeatherFailure).toEventually(beTrue())
                    }
                }
            }

            describe("getDailyWeather") {
                context("when it's called and succeeds") {
                    it("stores data and calls presenter with result") {
                        sut.getDailyWeather(request: Forecast.GetDailyWeather.Request(city: "Warsaw"))

                        expect(presenterSpy.presentDailyWeatherSuccess).toEventually(beTrue())
                    }
                }

                context("when it's called and weather is not present") {
                    it("calls presenter with error") {
                        workerMock.success = false

                        sut.getDailyWeather(request: Forecast.GetDailyWeather.Request(city: "Warsaw"))

                        expect(presenterSpy.presentDailyWeatherFailure).toEventually(beTrue())
                    }
                }
            }

            // MARK: - Test doubles
            
            class ForecastWorkerLogicMock: ForecastWorkerLogic {
                
                // MARK: - Properties

                var success = true

                // MARK: - Methods

                func getCurrentWeather(forCity city: String, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) {
                    if success {
                        completion(.success(CurrentWeatherResponse.mockObject))
                    } else {
                        completion(.failure(WFError.unknown))
                    }
                }

                func getDailyWeather(forCity city: String, completion: @escaping (Result<DailyWeatherListResponse, Error>) -> Void) {
                    if success {
                        completion(.success(DailyWeatherListResponse.mockObject))
                    } else {
                        completion(.failure(WFError.unknown))
                    }
                }
            }

            class ForecastPresentationLogicSpy: ForecastPresentationLogic {

                // MARK: - Properties
                
                var presentCurrentWeatherSuccess = false
                var presentCurrentWeatherFailure = false
                var presentDailyWeatherSuccess = false
                var presentDailyWeatherFailure = false
                
                // MARK: - Methods

                func presentCurrentWeather(response: Forecast.GetCurrentWeather.Response) {
                    switch response {
                    case .success:
                        presentCurrentWeatherSuccess = true
                    case .error:
                        presentCurrentWeatherFailure = true
                    }
                }

                func presentDailyWeather(response: Forecast.GetDailyWeather.Response) {
                    switch response {
                    case .success:
                        presentDailyWeatherSuccess = true
                    case .error:
                        presentDailyWeatherFailure = true
                    }
                }
            }
        }
    }
}
