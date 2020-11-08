//
//  RestServiceFactory.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 30/10/2020.
//

import Foundation
import Alamofire

struct RestServiceFactory {

    // MARK: - Init

    private init() {}

    // MARK: - Methods
    
    static func restService() -> RestServiceProtocol {
        return RestService(session: RestServiceFactory.session(), decoder: WFDecoder())
    }

    static func session() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary

        let certificates = Bundle.main.af.certificates
        let shouldValidateSSL = EnvironmentConfig.shouldValidateSSL
        var evaluators: [String: ServerTrustEvaluating] = [:]

        evaluators[EnvironmentConfig.apiHost] = PinnedCertificatesTrustEvaluator(certificates: certificates, acceptSelfSignedCertificates: !shouldValidateSSL, performDefaultValidation: shouldValidateSSL, validateHost: true)

        let manager = ServerTrustManager(evaluators: evaluators)

        return Session(configuration: configuration, serverTrustManager: manager)
    }
}
