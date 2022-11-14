//
//  Amount.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Foundation

// MARK: - Amount
struct Amount: Codable {
    let value: Double
    let currency: Currency
}
