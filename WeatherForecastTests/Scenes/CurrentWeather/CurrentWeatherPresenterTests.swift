//
//  CurrentWeatherPresenterTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class CurrentWeatherPresenterSpec: QuickSpec {
    
    override func spec() {
        describe("CurrentWeatherPresenter") {
            
            // MARK: - Properties

            var sut: CurrentWeatherPresenter!
            var viewControllerSpy: CurrentWeatherDisplayLogicSpy!
            
            // MARK: - Setup

            beforeEach {
                viewControllerSpy = CurrentWeatherDisplayLogicSpy()
                sut = CurrentWeatherPresenter(viewController: viewControllerSpy)
            }
            
            // MARK: - Tests

            describe("presentCurrentWeather") {
                context("when it's called with succes") {
                    it("calls viewController with success") {
                        sut.presentCurrentWeather(response: .success(CurrentWeatherResponse.mockObject))

                        expect(viewControllerSpy.displayCurrentWeatherCalled).to(beTrue())
                        expect(viewControllerSpy.viewModel?.feelsLike).to(equal("Feels like: 15°C"))
                    }
                }

                context("when it's called with error") {
                    it("calls viewController's displayToast") {
                        sut.presentCurrentWeather(response: .error(WFError.unknown))

                        expect(viewControllerSpy.displayErrorCalled).to(beTrue())
                    }
                }
            }

            // MARK: - Test doubles

            class CurrentWeatherDisplayLogicSpy: CurrentWeatherDisplayLogic {
                
                // MARK: - Properties
                
                var displayCurrentWeatherCalled = false
                var displayErrorCalled = false
                var viewModel: CurrentWeather.GetCurrentWeather.ViewModel?
                
                // MARK: - Methods

                func displayCurrentWeather(viewModel: CurrentWeather.GetCurrentWeather.ViewModel) {
                    displayCurrentWeatherCalled = true
                    self.viewModel = viewModel
                }

                func displayError(_ error: Error) {
                    displayErrorCalled = true
                }
            }
        }
    }
}
