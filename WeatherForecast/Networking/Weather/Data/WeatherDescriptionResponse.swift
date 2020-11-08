//
//  WeatherDescriptionResponse.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

struct WeatherDescriptionResponse: Decodable {
    let main: String?
    let description: String?
    let icon: String?
}
