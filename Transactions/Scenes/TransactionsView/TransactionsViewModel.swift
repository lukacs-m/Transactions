//
//  TransactionsViewModel.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//
//

import Combine
import Factory
import Foundation

final class TransactionsViewModel: ObservableObject {
    @Published var transactions: [(month: Month, transactions: [Transaction])] = []
    @LazyInjected(UseCasesContainer.getOrderedTransactions) private var getOrderedTransactions

    private var cancellables = Set<AnyCancellable>()

    init() {
        setUp()
    }
}

private extension TransactionsViewModel {
    func setUp() {
        getOrderedTransactions.execute()
            .receive(on: DispatchQueue.main)
            .sink { results in
                switch results {
                case let .failure(error):
                    print(error)
                case .finished:
                    print("finisehd")
                }
            } receiveValue: { [weak self] results in
                // let test =
                self?.transactions = results
//                Dictionary(grouping: results.transactions, by: \.month) // results.transactions
            }.store(in: &cancellables)
    }
}
