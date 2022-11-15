//
//  File.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import Combine
import Foundation

public protocol EasyNetworkingClient {
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) async throws -> ReturnedType
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) -> AnyPublisher<ReturnedType, Error>
}

extension EasyNetworkingClient {
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) async throws -> ReturnedType {
        guard let request = endpoint.request else {
            throw RequestError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(ReturnedType.self, from: data) else {
                    throw RequestError.decode
                }
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw RequestError.unknown
        }
    }

    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) -> AnyPublisher<ReturnedType, Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        let result: ReturnedType = try await sendRequest(endpoint: endpoint)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

private extension Endpoint {
    var request: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        guard let url = urlComponents.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        return request
    }
}
