//
//  DailyWeatherInteractorTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class DailyWeatherInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("DailyWeatherInteractor") {
            
            // MARK: - Properties
            
            var sut: DailyWeatherInteractor!
            var presenterSpy: DailyWeatherPresentationLogicSpy!
            var workerMock: DailyWeatherWorkerLogicMock!
            
            // MARK: - Setup
            
            beforeEach {
                presenterSpy = DailyWeatherPresentationLogicSpy()
                workerMock = DailyWeatherWorkerLogicMock()
                sut = DailyWeatherInteractor(presenter: presenterSpy, worker: workerMock)
            }
            
            // MARK: - Tests
            
            describe("getWeather") {
                context("when it's called and weather is present") {
                    it("calls presenter with result") {
                        sut.options[.weather] = DailyWeatherResponse.mockObject

                        sut.getWeather()

                        expect(presenterSpy.presentWeatherSuccess).toEventually(beTrue())
                    }
                }

                context("when it's called and weather is not present") {
                    it("calls presenter with error") {
                        sut.getWeather()

                        expect(presenterSpy.presentWeatherError).toEventually(beTrue())
                    }
                }
            }

            // MARK: - Test doubles
            
            class DailyWeatherWorkerLogicMock: DailyWeatherWorkerLogic {}

            class DailyWeatherPresentationLogicSpy: DailyWeatherPresentationLogic {

                // MARK: - Properties
                
                var presentWeatherSuccess = false
                var presentWeatherError = false
                
                // MARK: - Methods

                func presentWeather(response: DailyWeather.GetWeather.Response) {
                    switch response {
                    case .success:
                        presentWeatherSuccess = true
                    case .error:
                        presentWeatherError = true
                    }
                }
            }
        }
    }
}
