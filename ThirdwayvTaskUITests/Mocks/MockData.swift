//
//  MockData.swift
//  ThirdwayvTaskUITests
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import Foundation
@testable import ThirdwayvTask

class MockData: HTTPClientProtocol {
    func getData(completion: @escaping (Products?)-> Void) {
        guard let url = Bundle(for: MockData.self).url(forResource: "Products-JSON-Success",
                                                       withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return completion(nil)
        }
        let products = try? JSONDecoder().decode(Products.self, from: data)
        return completion(products)
    }
}
