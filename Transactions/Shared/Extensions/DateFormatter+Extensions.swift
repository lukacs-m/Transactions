//
//  DateFormatter+Extensions.swift
//  Transactions
//
//  Created by Martin Lukacs on 07/11/2022.
//

import Foundation

extension DateFormatter {

    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
