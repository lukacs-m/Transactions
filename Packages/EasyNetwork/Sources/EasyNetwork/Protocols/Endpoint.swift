//
//  Endpoint.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: CRUDRequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

public extension Endpoint {
    var scheme: String {
        "https"
    }
}
