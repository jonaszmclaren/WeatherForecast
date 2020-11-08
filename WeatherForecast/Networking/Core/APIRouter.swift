//
//  APIRouter.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 30/10/2020.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var baseURLString: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var additionalHeaders: HTTPHeaders { get }
    var requiresApiKey: Bool { get }
}

extension APIRouter {
    var baseURLString: String { EnvironmentConfig.baseURL }
    var method: HTTPMethod { .get }
    var path: String { "" }
    var parameters: Parameters? { nil }
    var encodableData: Encodable? { nil }
    var encoding: ParameterEncoding { method == .get ? URLEncoding.default : JSONEncoding.default }
    var additionalHeaders: HTTPHeaders { [:] }
    var requiresApiKey: Bool { true }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: (baseURLString + path).asURL())
        urlRequest.httpMethod = method.rawValue

        var headers = HTTPHeaders.default
        for header in additionalHeaders {
            headers.add(header)
        }

        urlRequest.headers = headers

        var requestParameters = parameters ?? [:]

        if requiresApiKey {
            requestParameters["appid"] = EnvironmentConfig.apiKey
        }

        urlRequest = try encoding.encode(urlRequest, with: requestParameters)

        return urlRequest
    }

    func prepareParameters<T: Encodable>(object: T) -> Parameters {
        guard let jsonData = try? JSONEncoder().encode(object), let dict = (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) as? Parameters else {
            return [:]
        }

        return dict
    }
}
