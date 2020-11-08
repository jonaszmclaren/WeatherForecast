//
//  DailyWeatherPresenterTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class DailyWeatherPresenterSpec: QuickSpec {
    
    override func spec() {
        describe("DailyWeatherPresenter") {
            
            // MARK: - Properties

            var sut: DailyWeatherPresenter!
            var viewControllerSpy: DailyWeatherDisplayLogicSpy!
            
            // MARK: - Setup

            beforeEach {
                viewControllerSpy = DailyWeatherDisplayLogicSpy()
                sut = DailyWeatherPresenter(viewController: viewControllerSpy)
            }
            
            // MARK: - Tests

            describe("presentWeather") {
                context("when it's called with succes") {
                    it("calls viewController with success") {
                        sut.presentWeather(response: .success(DailyWeatherResponse.mockObject))

                        expect(viewControllerSpy.displayWeatherCalled).to(beTrue())
                        expect(viewControllerSpy.viewModel?.maxTemperature).to(equal("Maximum temperature: 15°C"))
                    }
                }

                context("when it's called with error") {
                    it("calls viewController's displayToast") {
                        sut.presentWeather(response: .error(WFError.unknown))

                        expect(viewControllerSpy.displayErrorCalled).to(beTrue())
                    }
                }
            }
            
            // MARK: - Test doubles

            class DailyWeatherDisplayLogicSpy: DailyWeatherDisplayLogic {
                
                // MARK: - Properties
                
                var displayWeatherCalled = false
                var displayErrorCalled = false
                var viewModel: DailyWeather.GetWeather.ViewModel?
                
                // MARK: - Methods

                func displayWeather(viewModel: DailyWeather.GetWeather.ViewModel) {
                    displayWeatherCalled = true
                    self.viewModel = viewModel
                }

                func displayError(_ error: Error) {
                    displayErrorCalled = true
                }

            }
        }
    }
}
