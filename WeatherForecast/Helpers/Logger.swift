//
//  Logger.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 30/10/2020.
//

import Foundation
import os
import Alamofire
import Regex

enum LogLevel: String {
    case debug
    case off

    var osLogType: OSLogType? {
        switch self {
        case .debug:
            return OSLogType.debug
        case .off:
            return nil
        }
    }
}

enum LoggerSubsystem: String {
    case network
    case error
    case info

    var subsystem: String {
        return self.rawValue.uppercased()
    }

    func osLog(for category: String) -> OSLog {
        return OSLog(subsystem: self.subsystem, category: category)
    }
}

class Logger {

    // MARK: - Init

    private init() {}

    // MARK: - Methods

    private static func getFinalFilename(_ filePath: String) -> String {
        let parts = filePath.split(separator: "/")
        guard let lastPart = parts.last else {
            return filePath
        }
        return String(lastPart)
    }

    static func log(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        guard let osLogType = EnvironmentConfig.logLevel.osLogType else {
            return
        }

        let log = String(format: "[%@ | %@ | line:%d] Error - message: %@", getFinalFilename(file), function, line, error.localizedDescription)
        os_log("%@", log: LoggerSubsystem.error.osLog(for: "ERROR"), type: osLogType, log)
    }

    @discardableResult
    static func log(dataRequest: DataRequest) -> DataRequest {
        return logRequestAndResponse(dataRequest, level: EnvironmentConfig.logLevel)
    }

    private static func logRequestAndResponse(_ dataRequest: DataRequest, level: LogLevel) -> DataRequest {
        return logRequestAndResponse(dataRequest, level: level, withBodyHandler: { (data) -> Any? in
            guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
                let dataObject = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let body = String(bytes: dataObject, encoding: .utf8) else {
                    return nil
            }
            return body
        })
    }

    private static func logRequestAndResponse(_ dataRequest: DataRequest, level: LogLevel, withBodyHandler bodyHandler: @escaping (Data) -> Any?) -> DataRequest {
        guard let osLogType = level.osLogType else {
            return dataRequest
        }

        return dataRequest.response(completionHandler: {
            guard let method = $0.request?.httpMethod, let url = $0.request?.url, let statusCode = $0.response?.statusCode else {
                return
            }

            // Request
            var log = "\(method): \(url)"

            if level == .debug {
                if let headers = dataRequest.request?.allHTTPHeaderFields {
                    log += "\n\tHEADERS: ["
                    for header in headers {
                        log += "\n\t\t\(header.key): \(level != .debug && header.key == "Authorization" ? "****" : header.value)"
                    }
                    log += "\n\t]"
                }

                if let reqBody = dataRequest.request?.httpBody, let body = String(bytes: reqBody, encoding: .utf8) {
                    if let contentType = dataRequest.request?.value(forHTTPHeaderField: "Content-Type"), contentType.contains("application/x-www-form-urlencoded") {
                        log += "\n\tBODY:\n\t\(level != .debug ? hashUrlEncodedParams(body) : body)"
                    } else {
                        log += "\n\tBODY:\n\t\(level != .debug ? hashIfToken(body) : body)"
                    }
                }
            }

            os_log("%@", log: LoggerSubsystem.network.osLog(for: "REQUEST"), type: osLogType, log)

            // Response
            let requestDuration = String(format: "%.3fms", $0.metrics?.taskInterval.duration ?? 0.0 * 1000)
            log = "[STATUS HTTP: \(statusCode)] \(method): \(url)\n\tRequest duration: \(requestDuration)"

            if let error = $0.error?.localizedDescription {
                log += "\n\tERROR: \(error)\n\t"
            }

            if level == .debug {
                if let headers = $0.response?.allHeaderFields {
                    log += "\n\tHEADERS: ["
                    for header in headers {
                        log += "\n\t\t\(header.key): \(header.value)"
                    }
                    log += "\n\t]"
                }

                if let data = $0.data, let body = bodyHandler(data) {
                    log += "\n\tBODY:\n\(level != .debug ? self.hashIfToken(body as? String ?? "") : body)"
                }
            }

            os_log("%@", log: LoggerSubsystem.network.osLog(for: "RESPONSE"), type: osLogType, log)
        })
    }

    private static func hashIfToken(_ value: String) -> String {
        guard let regex = try? Regex(string: "[a-zA-Z0-9-_=]+\\.[a-zA-Z0-9-_=]+\\.[a-zA-Z0-9-_=]+") else {
            return value
        }
        return value.replacingAll(matching: regex, with: "****")
    }

    private static func hashUrlEncodedParams(_ body: String) -> String {
        guard let regex = try? Regex(string: "=[^&]+") else {
            return body
        }
        return body.replacingAll(matching: regex, with: "=****")
    }
}
