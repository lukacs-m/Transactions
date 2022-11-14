//
//  Transaction.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Foundation

// MARK: - Transaction

struct Transaction: Codable, Identifiable {
    let id = UUID().uuidString
    let name, type, date: String
    let message: String?
    let amount: Amount
    let smallIcon, largeIcon: Icon

    enum CodingKeys: String, CodingKey {
        case name, type, date, message, amount
        case smallIcon = "small_icon"
        case largeIcon = "large_icon"
    }

    var month: Month? {
        let dates = date.toDate()
        guard let dateDate = date.toDateString(outputFormat: "MMMM"),
              let month = dates?.get(.month) else {
            return nil
        }

        return Month(position: month, name: dateDate)
    }

    var shortDate: String {
        guard let dateDate = date.toDateString(outputFormat: "d MMMM") else {
            return " "
        }

        return dateDate
    }

    var longDate: String {
        guard let dateDate = date.toDateString(outputFormat: "EEEE d MMMM, HH:mm") else {
            return " "
        }

        return dateDate
    }

    var price: String {
        let amout = amount.value.sign == .minus ? "\(amount.value)" : "+\(amount.value)"
        return "\(amout) \(amount.currency.symbol)"
    }
}
