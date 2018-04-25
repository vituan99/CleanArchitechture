//
//  ProductItemViewModel.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct ProductItemViewModel {
    let id: String
    let name: String
    let price: Double
    let product: Product
    
    init(with product: Product) {
        self.id = product.id
        self.name = product.name
        self.price = product.price
        self.product = product
    }
}
