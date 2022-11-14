//
//  MockDataProvider.swift
//  TransactionsTests
//
//  Created by Martin Lukacs on 14/11/2022.
//

import Foundation

protocol MockDataProvider: AnyObject {
    var bundle: Bundle { get }
    func loadObject<T: Decodable>(filename: String) -> T
}

extension MockDataProvider {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadObject<ReturnedType: Decodable>(filename: String) -> ReturnedType {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(ReturnedType.self, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
