//
//  TransactionRepository.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Combine
import EasyNetwork
import Foundation

enum TransactionsEndpoint {
    case userTransactions
}

extension TransactionsEndpoint: Endpoint {
    var host: String {
        AppConfiguration.appNetworkHost
    }

    var path: String {
        switch self {
        case .userTransactions:
            return "/Aurazion/365d587f5917d1478bf03bacabdc69f3/raw/3c92b70e1dc808c8be822698f1cbff6c95ba3ad3/transactions.json"
        }
    }

    var method: CRUDRequestMethod {
        switch self {
        case .userTransactions:
            return .get
        }
    }

    var header: [String: String]? {
        nil
    }

    var body: [String: String]? {
        nil
    }
}

protocol TransactionServicing {
    func getUserTransactions() async throws -> Transactions
    func getUserTransactions() -> AnyPublisher<Transactions, Error>
}

struct TransactionRepository: EasyNetworkingClient, TransactionServicing {
    func getUserTransactions() async throws -> Transactions {
        try await sendRequest(endpoint: TransactionsEndpoint.userTransactions)
    }

    func getUserTransactions() -> AnyPublisher<Transactions, Error> {
        sendRequest(endpoint: TransactionsEndpoint.userTransactions)
    }
}
