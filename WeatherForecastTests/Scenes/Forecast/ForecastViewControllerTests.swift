//
//  ForecastViewControllerTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import WeatherForecast

class ForecastViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("ForecastViewController") {
            
            // MARK: - Properties

            var window: UIWindow!
            var sut: ForecastViewController!
            var interactorSpy: ForecastBusinessLogicSpy!
            var routerSpy: ForecastRoutingLogicSpy!
            
            // MARK: - Setup

            beforeEach {
                window = UIWindow()
                interactorSpy = ForecastBusinessLogicSpy()
                routerSpy = ForecastRoutingLogicSpy()
                sut = Scene.forecast.viewController as? ForecastViewController
                sut.interactor = interactorSpy
                sut.router = routerSpy
                
                window.addSubview(sut.view)
                RunLoop.current.run(until: Date())
            }
            
            afterEach {
                window = nil
            }
            
            // MARK: - Tests

            describe("view loading") {
                context("when view loads") {
                    it("calls interactor") {
                        expect(interactorSpy.getCurrentWeatherCalled).to(beTrue())
                        expect(interactorSpy.getDailyWeatherCalled).to(beTrue())
                    }
                }
            }

            describe("cellSelected") {
                context("when it's called") {
                    it("calls router") {
                        sut.cellSelected(index: 1)

                        expect(routerSpy.routeToDailyWeatherCalled).to(beTrue())
                    }
                }
            }

            // MARK: - Test doubles
            
            class ForecastBusinessLogicSpy: ForecastBusinessLogic {
                
                // MARK: - Properties
                
                var getCurrentWeatherCalled = false
                var getDailyWeatherCalled = false
                
                // MARK: - Methods

                func getCurrentWeather(request: Forecast.GetCurrentWeather.Request) {
                    getCurrentWeatherCalled = true
                }

                func getDailyWeather(request: Forecast.GetDailyWeather.Request) {
                    getDailyWeatherCalled = true
                }
            }
            
            class ForecastRoutingLogicSpy: NSObject, ForecastRoutingLogic, ForecastDataPassing {
                
                // MARK: - Properties

                var dataStore: ForecastDataStore?
                var routeToCurrentWeatherCalled = false
                var routeToDailyWeatherCalled = false
                
                // MARK: - Methods

                func routeToCurrentWeather() {
                    routeToCurrentWeatherCalled = true
                }

                func routeToDailyWeather(index: Int) {
                    routeToDailyWeatherCalled = true
                }
            }
        }
    }
}
