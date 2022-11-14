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

enum PageState {
    case loading
    case loaded
    case error(String)
}

final class TransactionsViewModel: ObservableObject {
    @Published var pageState: PageState = .loading
    @Published var transactions: [(month: Month, transactions: [Transaction])] = []
    @LazyInjected(UseCasesContainer.getOrderedTransactions) private var getOrderedTransactions

    private var loadDataTask: Task<Void, Error>?

    init() {
        setUp()
    }

    func loadData() {
        loadDataTask?.cancel()
        loadDataTask = Task {
            do {
                let transactions = try await getOrderedTransactions.execute()
                if Task.isCancelled {
                    return
                }
                await updateTransactions(with: transactions)
                await updatePageState(with: .loaded)
            } catch {
                await updatePageState(with: .error(error.localizedDescription))
            }
        }
    }
}

// MARK: - UI Update

private extension TransactionsViewModel {
    @MainActor
    func updateTransactions(with newTransaction: [(month: Month, transactions: [Transaction])]) {
        pageState = .loaded
        transactions = newTransaction
    }

    @MainActor
    func updatePageState(with newPageState: PageState) {
        pageState = newPageState
    }
}

private extension TransactionsViewModel {
    func setUp() {}
}
