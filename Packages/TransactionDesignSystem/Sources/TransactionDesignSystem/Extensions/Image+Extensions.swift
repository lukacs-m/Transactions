//
//  Image+Extensions.swift
//
//
//  Created by Martin Lukacs on 20/11/2022.
//

import SwiftUI

public extension Image {
    init(iconName name: String) {
        self.init(name, bundle: .module)
    }
}
