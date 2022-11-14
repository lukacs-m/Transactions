//
//  Transaction+Extensions.swift
//  Transactions
//
//  Created by Martin Lukacs on 12/11/2022.
//

import DesignSystem

extension Transaction {
    var toTransactionCellModel: TransactionModel {
        TransactionModel(id: id,
                             title: name,
                             price: price,
                             subtitle: shortDate,
                             mainIcon: IconModel(type: type,
                                                 name: largeIcon.category,
                                                 url: largeIcon.url),
                             smallIcon: IconModel(type: type,
                                                  name: smallIcon.category,
                                                  url: smallIcon.url))
    }
    
    var toFullScreenModel: TransactionModel {
        TransactionModel(id: id,
                             title: name,
                             price: price,
                             subtitle: longDate,
                             mainIcon: IconModel(type: type,
                                                 name: largeIcon.category,
                                                 url: largeIcon.url),
                             smallIcon: IconModel(type: type,
                                                  name: smallIcon.category,
                                                  url: smallIcon.url))
    }
}
