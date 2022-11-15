//
//  TransactionRepositoryMock.swift
//  TransactionsTests
//
//  Created by Martin Lukacs on 14/11/2022.
//

import Combine
import Foundation
import EasyNetwork
@testable import Transactions

enum TestError: Error {
    case generic
}

class TransactionRepositoryMock: EasyNetworkingClient, TransactionServicing, MockDataProvider {
    func getUserTransactions() async throws -> Transactions {
        try await sendRequest(endpoint: TransactionsEndpoint.userTransactions)
    }

    func getUserTransactions() -> AnyPublisher<Transactions, Error> {
        sendRequest(endpoint: TransactionsEndpoint.userTransactions)
    }
    
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) async throws -> ReturnedType {
        loadObject(filename: "transactions")
    }
    
    func sendRequest<ReturnedType: Decodable>(endpoint: Endpoint) -> AnyPublisher<ReturnedType, Error> {
        Just(loadObject(filename: "transactions")).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
