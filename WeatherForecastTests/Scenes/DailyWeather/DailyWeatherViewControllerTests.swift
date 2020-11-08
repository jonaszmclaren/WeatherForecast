//
//  DailyWeatherViewControllerTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import WeatherForecast

class DailyWeatherViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("DailyWeatherViewController") {
            
            // MARK: - Properties

            var window: UIWindow!
            var sut: DailyWeatherViewController!
            var interactorSpy: DailyWeatherBusinessLogicSpy!
            
            // MARK: - Setup

            beforeEach {
                window = UIWindow()
                interactorSpy = DailyWeatherBusinessLogicSpy()
                sut = Scene.dailyWeather.viewController as? DailyWeatherViewController
                sut.interactor = interactorSpy
                
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
                        expect(interactorSpy.getWeatherCalled).to(beTrue())
                    }
                }
            }
            
            // MARK: - Test doubles
            
            class DailyWeatherBusinessLogicSpy: DailyWeatherBusinessLogic {
                
                // MARK: - Properties
                
                var getWeatherCalled = false
                
                // MARK: - Methods

                func getWeather() {
                    getWeatherCalled = true
                }
            }
        }
    }
}
