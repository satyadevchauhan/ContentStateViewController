//
//  Products.swift
//  ContainerViewController
//
//  Created by Satyadev Chauhan on 07/01/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

struct Products: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let name: String
    let price: Double
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case price = "Price"
        case location = "Location"
    }
}
