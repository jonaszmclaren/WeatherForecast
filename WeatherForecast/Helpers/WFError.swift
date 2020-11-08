//
//  WFError.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 07/11/2020.
//

import Foundation

enum WFError: Error, LocalizedError {
    case unknown

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error."
        }
    }
}
