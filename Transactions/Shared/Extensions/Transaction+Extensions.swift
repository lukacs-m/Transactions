//
//  Transaction+Extensions.swift
//  Transactions
//
//  Created by Martin Lukacs on 12/11/2022.
//

import TransactionDesignSystem

extension Transaction {
    var toTransactionCellModel: TransactionUIModel {
        TransactionUIModel(id: id,
                           title: name,
                           subtitle: shortDate,
                           price: price,
                           mainIcon: IconUIModel(type: type,
                                                 category: largeIcon.category,
                                                 url: largeIcon.url),
                           smallIcon: IconUIModel(type: type,
                                                  category: smallIcon.category,
                                                  url: smallIcon.url))
    }

    var toDetailScreenModel: TransactionUIModel {
        TransactionUIModel(id: id,
                           title: name,
                           subtitle: longDate,
                           price: price,
                           mainIcon: IconUIModel(type: type,
                                                 category: largeIcon.category,
                                                 url: largeIcon.url),
                           smallIcon: IconUIModel(type: type,
                                                  category: smallIcon.category,
                                                  url: smallIcon.url))
    }
}
