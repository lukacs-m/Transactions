//
//  Currency.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Foundation

// MARK: - Currency

struct Currency: Codable {
    let iso3, symbol, title: String

    enum CodingKeys: String, CodingKey {
        case iso3 = "iso_3"
        case symbol, title
    }
}
