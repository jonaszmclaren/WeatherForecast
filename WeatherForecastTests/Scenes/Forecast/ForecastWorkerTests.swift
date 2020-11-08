//
//  ForecastWorkerTests.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 08/11/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherForecast

class ForecastWorkerSpec: QuickSpec {
    
    override func spec() {
        describe("ForecastWorker") {
            
            // MARK: - Properties

            var sut: ForecastWorker!
            var weatherRestServiceMock: WeatherRestServiceMock!
            
            // MARK: - Setup

            beforeEach {
                weatherRestServiceMock = WeatherRestServiceMock()
                sut = ForecastWorker(weatherRestService: weatherRestServiceMock)
            }
            
            // MARK: - Tests
            
            describe("getCurrentWeather") {
                context("when request succeeds") {
                    it("return data from API") {
                        var success = false
                        var successResponse: CurrentWeatherResponse?
                        var errorResponse: Error?

                        sut.getCurrentWeather(forCity: "Warsaw", completion: { result in
                            switch result {
                            case .success(let response):
                                success = true
                                successResponse = response
                            case .failure(let error):
                                success = false
                                errorResponse = error
                            }
                        })

                        expect(success).toEventually(beTrue())
                        expect(successResponse).toEventuallyNot(beNil())
                        expect(errorResponse).toEventually(beNil())
                    }
                }

                context("when request errors out") {
                    it("returns an error") {
                        weatherRestServiceMock.success = false
                        var success = true
                        var successResponse: CurrentWeatherResponse?
                        var errorResponse: Error?

                        sut.getCurrentWeather(forCity: "Warsaw", completion: { result in
                            switch result {
                            case .success(let response):
                                success = true
                                successResponse = response
                            case .failure(let error):
                                success = false
                                errorResponse = error
                            }
                        })

                        expect(success).toEventually(beFalse())
                        expect(successResponse).toEventually(beNil())
                        expect(errorResponse).toEventuallyNot(beNil())
                    }
                }

                describe("getDailyWeather") {
                    context("when request succeeds") {
                        it("return data from API") {
                            var success = false
                            var successResponse: DailyWeatherListResponse?
                            var errorResponse: Error?

                            sut.getDailyWeather(forCity: "Warsaw", completion: { result in
                                switch result {
                                case .success(let response):
                                    success = true
                                    successResponse = response
                                case .failure(let error):
                                    success = false
                                    errorResponse = error
                                }
                            })

                            expect(success).toEventually(beTrue())
                            expect(successResponse).toEventuallyNot(beNil())
                            expect(errorResponse).toEventually(beNil())
                        }
                    }

                    context("when request errors out") {
                        it("returns an error") {
                            weatherRestServiceMock.success = false
                            var success = true
                            var successResponse: DailyWeatherListResponse?
                            var errorResponse: Error?

                            sut.getDailyWeather(forCity: "Warsaw", completion: { result in
                                switch result {
                                case .success(let response):
                                    success = true
                                    successResponse = response
                                case .failure(let error):
                                    success = false
                                    errorResponse = error
                                }
                            })

                            expect(success).toEventually(beFalse())
                            expect(successResponse).toEventually(beNil())
                            expect(errorResponse).toEventuallyNot(beNil())
                        }
                    }
                }
            }
        }
    }
}
