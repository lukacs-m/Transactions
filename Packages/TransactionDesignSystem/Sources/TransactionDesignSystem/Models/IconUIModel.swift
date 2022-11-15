//
//  IconUIModel.swift
//
//
//  Created by Martin Lukacs on 15/11/2022.
//

import Foundation

public struct IconUIModel {
    let type: String
    let category: String
    let url: String

    public init(type: String, category: String, url: String) {
        self.type = type
        self.category = category
        self.url = url
    }
}
