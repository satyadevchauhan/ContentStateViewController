//
//  Result.swift
//  ContainerViewController
//
//  Created by Satyadev Chauhan on 07/01/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

enum Result<Success, Error: Swift.Error> {
    case success(Success)
    case failure(Error)
}

// If success is Data type we will try to decode as generic model type.
extension Result where Success == Data {
    func decoded<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}

extension Result {
    func get() throws -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
