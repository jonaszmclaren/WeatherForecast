//
//  CurrentWeatherInteractorTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class CurrentWeatherInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("CurrentWeatherInteractor") {
            
            // MARK: - Properties
            
            var sut: CurrentWeatherInteractor!
            var presenterSpy: CurrentWeatherPresentationLogicSpy!
            var workerMock: CurrentWeatherWorkerLogicMock!
            
            // MARK: - Setup
            
            beforeEach {
                presenterSpy = CurrentWeatherPresentationLogicSpy()
                workerMock = CurrentWeatherWorkerLogicMock()
                sut = CurrentWeatherInteractor(presenter: presenterSpy, worker: workerMock)
            }
            
            // MARK: - Tests
            
            describe("getCurrentWeather") {
                context("when it's called and weather is present") {
                    it("calls presenter with result") {
                        sut.options[.currentWeather] = CurrentWeatherResponse.mockObject

                        sut.getCurrentWeather()

                        expect(presenterSpy.presentCurrentWeatherSuccess).toEventually(beTrue())
                    }
                }

                context("when it's called and weather is not present") {
                    it("calls presenter with error") {
                        sut.getCurrentWeather()

                        expect(presenterSpy.presentCurrentWeatherError).toEventually(beTrue())
                    }
                }
            }

            // MARK: - Test doubles
            
            class CurrentWeatherWorkerLogicMock: CurrentWeatherWorkerLogic {}

            class CurrentWeatherPresentationLogicSpy: CurrentWeatherPresentationLogic {

                // MARK: - Properties

                var presentCurrentWeatherSuccess = false
                var presentCurrentWeatherError = false
                
                // MARK: - Methods

                func presentCurrentWeather(response: CurrentWeather.GetCurrentWeather.Response) {
                    switch response {
                    case .success:
                        presentCurrentWeatherSuccess = true
                    case .error:
                        presentCurrentWeatherError = true
                    }
                }
            }
        }
    }
}
