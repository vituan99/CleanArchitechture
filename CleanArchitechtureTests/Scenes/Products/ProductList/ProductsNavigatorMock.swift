//
//  ProductsNavigatorMock.swift
//  CleanArchitechtureTests
//
//  Created by Tuan Truong on 1/12/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

@testable import CleanArchitechture

class ProductsNavigatorMock: ProductsNavigatorType {
    var toProducts_Called = false
    var toCreateProduct_Called = false
    var toEditProduct_Called = false
    
    func toProducts() {
        toProducts_Called = true
    }
    
    func toCreateProduct() {
        toCreateProduct_Called = true
    }
    
    func toEditProduct(_ product: Product) {
        toEditProduct_Called = true
    }
}
