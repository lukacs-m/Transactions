//
//  IconUIModel.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import Foundation
import SwiftUI

public struct IconUIModel {
    let type: String
    let category: String
    let url: String?

    public init(type: String, category: String, url: String?) {
        self.type = type
        self.category = category
        self.url = url
    }
}

extension IconUIModel {
    var backgroundColor: Color {
        switch type {
        case "meal_voucher":
            return Asset.Colors.Backgrounds.backgroundOrange.color
        case "gift":
            return Asset.Colors.Backgrounds.backgroundPink.color
        case "mobility":
            return Asset.Colors.Backgrounds.backgroundRed.color
        default:
            return .white
        }
    }

    var color: Color {
        switch type {
        case "meal_voucher":
            return Asset.Colors.Main.orange.color
        case "gift":
            return Asset.Colors.Main.pink.color
        case "mobility":
            return Asset.Colors.Main.red.color
        default:
            return .black
        }
    }
}
