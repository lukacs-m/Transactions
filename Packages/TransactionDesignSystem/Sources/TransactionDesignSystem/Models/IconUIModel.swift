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
            return Asset.Colors.Backgrounds.orange.color
        case "gift":
            return Asset.Colors.Backgrounds.pink.color
        case "mobility":
            return Asset.Colors.Backgrounds.red.color
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
//
//    var mainIcon: Image {
//        switch type {
//        case "bakery":
//            return Asset.Assets.BigIcons.bakery.image
//        case "burger":
//            return Asset.Assets.BigIcons.burger.image
//        case "computer":
//            return Asset.Assets.BigIcons.computer.image
//        case "burger":
//            return Asset.Assets.BigIcons.burger.image
//        default:
//            return .white
//        }
//    }
}

// public static let bakery = SecuredIcons(name: "bakery")
// public static let burger = SecuredIcons(name: "burger")
// public static let computer = SecuredIcons(name: "computer")
// public static let supermarket = SecuredIcons(name: "supermarket")
// public static let sushi = SecuredIcons(name: "sushi")
// public static let train = SecuredIcons(name: "train")
