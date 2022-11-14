//
//  String+Extensions.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Foundation

extension String {
    func toDate(dateFormatter: DateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")) -> Date? {
        dateFormatter.date(from: self)
    }

    func toDateString(dateFormatter: DateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"),
                      outputFormat: String) -> String? {
        guard let date = toDate(dateFormatter: dateFormatter) else { return nil }
        return DateFormatter(format: outputFormat).string(from: date)
    }
}
