//
//  GetOrderedTransactions.swift
//  Transactions
//
//  Created by Martin Lukacs on 12/11/2022.
//

import Combine
import Factory
import Foundation

protocol GetOrderedTransactionsUseCase {
    func execute() -> AnyPublisher<[(month: Month, transactions: [Transaction])], Error>
    func execute() async throws -> [(month: Month, transactions: [Transaction])]
}

final class GetOrderedTransactions: GetOrderedTransactionsUseCase {
    @LazyInjected(RepositoriesContainer.transactionRepository) private var transactionRepository

    private var cancellables = Set<AnyCancellable>()

    init() {}

    /// Fetches the favorites stats for  user.
    /// - Returns: The informations of user's favorites
    func execute() -> AnyPublisher<[(month: Month, transactions: [Transaction])], Error> {
        transactionRepository.getUserTransactions()
            .map { [weak self] results in
                let orderedTransactions = self?.orderTransactionByMonth(for: results) ?? []
                return orderedTransactions
            }.eraseToAnyPublisher()
    }

    /// Fetches the favorites stats for  user.
    /// - Returns: The informations of user's favorites
    func execute() async throws -> [(month: Month, transactions: [Transaction])] {
        let results = try await transactionRepository.getUserTransactions()
        let orderedTransactions = orderTransactionByMonth(for: results)
        return orderedTransactions
    }
}

private extension GetOrderedTransactions {
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
