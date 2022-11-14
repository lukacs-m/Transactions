//
//  GetOrderedTransactionsMock.swift
//  TransactionsTests
//
//  Created by Martin Lukacs on 14/11/2022.
//

import Combine
import Foundation
import Factory
import Network
@testable import Transactions

final class GetOrderedTransactionsMock: GetOrderedTransactionsUseCase {
    @LazyInjected(RepositoriesContainer.transactionRepository) private var transactionRepository

    var executePublisherWasCalled = false
    var executeAsyncWasCalled = false
    private var cancellables = Set<AnyCancellable>()

    init() {}

    func execute() -> AnyPublisher<[(month: Month, transactions: [Transaction])], Error> {
        executePublisherWasCalled = true
        return transactionRepository.getUserTransactions()
            .map { [weak self] results in
                let orderedTransactions = self?.orderTransactionByMonth(for: results) ?? []
                return orderedTransactions
            }.eraseToAnyPublisher()
    }

    func execute() async throws -> [(month: Month, transactions: [Transaction])] {
        executeAsyncWasCalled = true
        let results = try await transactionRepository.getUserTransactions()
        let orderedTransactions = orderTransactionByMonth(for: results)
        return orderedTransactions
    }
    
    func orderTransactionByMonth(for transactions: Transactions) -> [(month: Month, transactions: [Transaction])] {
        let groupedTransations = Dictionary(grouping: transactions.transactions,
                                            by: \.month!)
            .sorted(by: { $0.0.position > $1.0.position })
        var returnResults: [(month: Month, transactions: [Transaction])] = []
        for sortedTransaction in groupedTransations {
            returnResults.append((month: sortedTransaction.key, transactions: sortedTransaction.value))
        }
        return returnResults
    }
}
