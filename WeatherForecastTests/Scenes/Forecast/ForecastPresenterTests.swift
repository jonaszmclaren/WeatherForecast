//
//  ForecastPresenterTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class ForecastPresenterSpec: QuickSpec {
    
    override func spec() {
        describe("ForecastPresenter") {
            
            // MARK: - Properties

            var sut: ForecastPresenter!
            var viewControllerSpy: ForecastDisplayLogicSpy!
            
            // MARK: - Setup

            beforeEach {
                viewControllerSpy = ForecastDisplayLogicSpy()
                sut = ForecastPresenter(viewController: viewControllerSpy)
            }
            
            // MARK: - Tests

            describe("presentCurrentWeather") {
                context("when it's called with succes") {
                    it("calls viewController with success") {
                        sut.presentCurrentWeather(response: .success(CurrentWeatherResponse.mockObject))

                        expect(viewControllerSpy.displayCurrentWeatherCalled).to(beTrue())
                        expect(viewControllerSpy.currentWeatherViewModel?.feelsLike).to(equal("Feels like: 15°C"))
                    }
                }

                context("when it's called with error") {
                    it("calls viewController's displayToast") {
                        sut.presentCurrentWeather(response: .error(WFError.unknown))

                        expect(viewControllerSpy.displayErrorCalled).to(beTrue())
                    }
                }
            }

            describe("presentDailyWeather") {
                context("when it's called with succes") {
                    it("calls viewController with success") {
                        sut.presentDailyWeather(response: .success(DailyWeatherListResponse.mockObject))

                        expect(viewControllerSpy.displayDailyWeatherCalled).to(beTrue())
                        expect(viewControllerSpy.dailyWeatherViewModel?.days.first?.nightTemperature).to(equal("12"))
                    }
                }

                context("when it's called with error") {
                    it("calls viewController's displayToast") {
                        sut.presentDailyWeather(response: .error(WFError.unknown))

                        expect(viewControllerSpy.displayErrorCalled).to(beTrue())
                    }
                }
            }

            // MARK: - Test doubles

            class ForecastDisplayLogicSpy: ForecastDisplayLogic {
                
                // MARK: - Properties
                
                var displayCurrentWeatherCalled = false
                var displayDailyWeatherCalled = false
                var displayErrorCalled = false
                var currentWeatherViewModel: Forecast.GetCurrentWeather.ViewModel?
                var dailyWeatherViewModel: Forecast.GetDailyWeather.ViewModel?
                
                // MARK: - Methods

                func displayCurrentWeather(viewModel: Forecast.GetCurrentWeather.ViewModel) {
                    displayCurrentWeatherCalled = true
                    currentWeatherViewModel = viewModel
                }

                func displayDailyWeather(viewModel: Forecast.GetDailyWeather.ViewModel) {
                    displayDailyWeatherCalled = true
                    dailyWeatherViewModel = viewModel
                }

                func displayError(_ error: Error) {
                    displayErrorCalled = true
                }
            }
        }
    }
}
