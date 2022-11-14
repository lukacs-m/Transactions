//
//  UseCases+Dependencies.swift
//  Transactions
//
//  Created by Martin Lukacs on 12/11/2022.
//

import Factory

/// Container for repositories
final class UseCasesContainer: SharedContainer {
    static let getOrderedTransactions = Factory<GetOrderedTransactionsUseCase>(scope: .shared) {
        GetOrderedTransactions()
    }
}
