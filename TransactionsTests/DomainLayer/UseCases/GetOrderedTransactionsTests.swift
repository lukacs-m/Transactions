//
//  GetOrderedTransactionsTests.swift
//  TransactionsTests
//
//  Created by Martin Lukacs on 14/11/2022.
//

import Combine
import Factory
import XCTest
@testable import Transactions

final class GetOrderedTransactionsTests: XCTestCase {
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
        cancellable?.cancel()
    }

    func testGetOrderedTransactionsCombine() throws {
   
        let sut = GetOrderedTransactions()

        let expectation = XCTestExpectation(description: "wait for completion")
        cancellable = sut.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure:
                    XCTFail("Should not return a error")
                }
            } receiveValue: { transactions in
                XCTAssertEqual(transactions.count, 3)
                XCTAssertEqual(transactions.first?.transactions.count, 4)
                XCTAssertEqual(transactions.last?.transactions.count, 1)
                expectation.fulfill()
            }
        XCTWaiter().wait(for: [expectation], timeout: 5)
    }
    
    func testGetOrderedTransactionsAsync() async throws {
        let transactionRepoMock = TransactionRepositoryMock()
        RepositoriesContainer.transactionRepository.register(factory: { transactionRepoMock })
        let sut = GetOrderedTransactions()

       let transactions = try await sut.execute()
        XCTAssertEqual(transactions.count, 3)
        XCTAssertEqual(transactions.first?.transactions.count, 4)
        XCTAssertEqual(transactions.last?.transactions.count, 1)
    }
}
