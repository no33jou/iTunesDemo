//
//  APIService.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/5.
//

import Combine
import Foundation
protocol APIable {
    var request: URLRequest? { get }
}

enum APIFailure: Error {
    case decode
    case network
    case unowned
}

extension APIable {
    func fetch<T: Codable>(type: T.Type) -> AnyPublisher<T, APIFailure>? {
        APIService.shared.fetch(api: self, type: T.self)
    }
}

class APIService {
    static let shared = APIService()
    private init() {}

    func fetch<T: Codable>(api: any APIable, type: T.Type) -> AnyPublisher<T, APIFailure>? {
        guard let request = api.request else {
            assertionFailure("APIService:Not request from \(api.self)")
            return nil
        }
        let task = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchSerialQueue.main)
            .mapError { error in
                switch error {
                case is URLError:
                    return APIFailure.network
                case is EncodingError:
                    return APIFailure.decode
                default:
                    return APIFailure.unowned
                }
            }
            .eraseToAnyPublisher()

        return task
    }
}
