//
//  Repositories+Dependencies.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Factory

/// Container for repositories
final class RepositoriesContainer: SharedContainer {
    static let transactionRepository = Factory<TransactionServicing>(scope: .singleton) {
        TransactionRepository()
    }
}
