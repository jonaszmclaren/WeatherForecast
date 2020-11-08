//
//  EnvironmentConfig.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 30/10/2020.
//

import Foundation

struct EnvironmentConfig {

    // MARK: - Init

    private init() {}

    // MARK: - Properties

    private static var info: [String: Any] {
        return Bundle.main.infoDictionary ?? [:]
    }

    static var apiKey: String {
        return stringValueFromInfo(by: "APIKey")
    }

    static var apiHost: String {
        return stringValueFromInfo(by: "APIHost")
    }

    static var baseURL: String {
        let apiProtocol = stringValueFromInfo(by: "APIProtocol")
        let apiHost = stringValueFromInfo(by: "APIHost")
        let apiEndpoint = stringValueFromInfo(by: "APIEndpoint")

        return "\(apiProtocol)://\(apiHost)/\(apiEndpoint)"
    }

    static var logLevel: LogLevel {
        guard let logLevel = LogLevel(rawValue: stringValueFromInfo(by: "LogLevel").lowercased()) else {
            return .off
        }

        return logLevel
    }

    static var shouldValidateSSL: Bool {
        return stringValueFromInfo(by: "ShouldValidateSSL") == "1"
    }

    // MARK: - Methods

    private static func stringValueFromInfo(by key: String) -> String {
        guard let string = info[key] as? String else {
            return ""
        }

        return string
    }
}
