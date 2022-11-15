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
                                                 name: largeIcon.category,
                                                 url: largeIcon.url),
                           smallIcon: IconUIModel(type: type,
                                                  name: smallIcon.category,
                                                  url: smallIcon.url))
    }

    var toFullScreenModel: TransactionUIModel {
        TransactionUIModel(id: id,
                           title: name,
                           subtitle: longDate,
                           price: price,
                           mainIcon: IconUIModel(type: type,
                                                 name: largeIcon.category,
                                                 url: largeIcon.url),
                           smallIcon: IconUIModel(type: type,
                                                  name: smallIcon.category,
                                                  url: smallIcon.url))
    }
}
