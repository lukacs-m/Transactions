//
//  TransactionsViewModelTests.swift
//  TransactionsTests
//
//  Created by Martin Lukacs on 14/11/2022.
//

import Combine
import Foundation
import XCTest
import Factory
@testable import Transactions

final class TransactionsViewModelTests: XCTestCase {
    var cancellable: AnyCancellable?

    override func setUp() {
        super.setUp()
        Container.Registrations.push()
        let transactionRepoMock = TransactionRepositoryMock()
        RepositoriesContainer.transactionRepository.register(factory: { transactionRepoMock })
    }

    override func tearDown() {
        super.tearDown()
        Container.Registrations.pop()
    }

    func testTransactionsViewModelDataLoading() throws {
//        RepositoriesContainer.transactionRepository.register(factory: { TransactionRepositoryMock() })
        let getOrderedTransactionsMock = GetOrderedTransactionsMock()
        UseCasesContainer.getOrderedTransactions.register(factory: { getOrderedTransactionsMock })

        let sut = TransactionsViewModel()
        sut.loadData()
        let expectation = XCTestExpectation(description: "wait for completion")

        cancellable = sut.$pageState
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure:
                    XCTFail("Should not return a error")
                }
            } receiveValue: { state in
                XCTAssertTrue(getOrderedTransactionsMock.executeAsyncWasCalled)
                XCTAssertEqual(sut.transactions.first?.transactions.count, 4)
                XCTAssertEqual(sut.transactions.last?.transactions.count, 1)
                expectation.fulfill()
            }
        XCTWaiter().wait(for: [expectation], timeout: 5)
    }
}
