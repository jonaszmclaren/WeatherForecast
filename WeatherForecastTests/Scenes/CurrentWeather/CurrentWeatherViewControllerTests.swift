//
//  CurrentWeatherViewControllerTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import WeatherForecast

class CurrentWeatherViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("CurrentWeatherViewController") {
            
            // MARK: - Properties

            var window: UIWindow!
            var sut: CurrentWeatherViewController!
            var interactorSpy: CurrentWeatherBusinessLogicSpy!

            // MARK: - Setup

            beforeEach {
                window = UIWindow()
                interactorSpy = CurrentWeatherBusinessLogicSpy()
                sut = Scene.currentWeather.viewController as? CurrentWeatherViewController
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
                        expect(interactorSpy.getCurrentWeatherCalled).to(beTrue())
                    }
                }
            }

            // MARK: - Test doubles
            
            class CurrentWeatherBusinessLogicSpy: CurrentWeatherBusinessLogic {
                
                // MARK: - Properties
                
                var getCurrentWeatherCalled = false
                
                // MARK: - Methods

                func getCurrentWeather() {
                    getCurrentWeatherCalled = true
                }
            }
        }
    }
}
