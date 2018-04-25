//
//  ProductsUseCaseMock.swift
//  CleanArchitechtureTests
//
//  Created by Tuan Truong on 1/12/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

@testable import CleanArchitechture

class ProductsUseCaseMock: ProductsUseCaseType {
    var products_Called = false
    var update_Called = false
    var add_Called = false
    
    var products_ReturnValue = Observable.just(ProductsUseCaseMock._products)
    var update_ReturnValue = Observable.just(())
    var add_ReturnValue = Observable.just(())
    
    private static var _products: [Product] = [
        Product(id: "iphone", name: "iPhone", price: 700)
    ]
    
    func products() -> Observable<[Product]> {
        products_Called = true
        return products_ReturnValue
    }
    
    func update(_ product: Product) -> Observable<Void> {
        update_Called = true
        return update_ReturnValue
    }
    
    func add(_ product: Product) -> Observable<Void> {
        add_Called = true
        return add_ReturnValue
    }
    

}
