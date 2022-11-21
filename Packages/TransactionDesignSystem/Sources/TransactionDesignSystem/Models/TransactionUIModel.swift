//
//  TransactionUIModel.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import Foundation
import SwiftUI

public struct TransactionUIModel {
    let id: String
    let title: String
    let subtitle: String
    let price: String
    let mainIcon: IconUIModel
    let smallIcon: IconUIModel

    public init(id: String, title: String, subtitle: String, price: String, mainIcon: IconUIModel, smallIcon: IconUIModel) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.mainIcon = mainIcon
        self.smallIcon = smallIcon
    }
}
