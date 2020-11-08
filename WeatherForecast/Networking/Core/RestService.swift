//
//  RestService.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 30/10/2020.
//

import Foundation
import Alamofire

protocol RestServiceProtocol {
    func getObject<T>(router: APIRouter, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable
    func getArray<T>(router: APIRouter, completion: @escaping (Result<[T], Error>) -> Void) where T: Decodable
}

class RestService: RestServiceProtocol {

    // MARK: - Properties

    let session: Session
    let decoder: JSONDecoder

    // MARK: - Init

    init(session: Session, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Methods

    func getObject<T>(router: APIRouter, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        session.request(router)
            .validate()
            .log()
            .responseDecodable(of: T.self, decoder: decoder) { response in
                if let object = response.value {
                    completion(.success(object))
                } else if let error = response.error {
                    completion(.failure(error))
                }
            }
    }

    func getArray<T>(router: APIRouter, completion: @escaping (Result<[T], Error>) -> Void) where T: Decodable {
        session.request(router)
            .validate()
            .log()
            .responseDecodable(of: [T].self, decoder: decoder) { response in
                if let objects = response.value {
                    completion(.success(objects))
                } else if let error = response.error {
                    completion(.failure(error))
                }
            }
    }
}
