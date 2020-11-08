//
//  CoordinatesDto.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 05/11/2020.
//

import Foundation

struct CoordinatesDto: Codable {
    let longitude: Double?
    let latitude: Double?

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
