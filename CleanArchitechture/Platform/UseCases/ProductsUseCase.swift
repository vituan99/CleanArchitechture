//
//  ProductsUseCase.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct ProductsUseCase: ProductsUseCaseType {
    static private var _products: [Product] = [
        Product(id: "iphone", name: "iPhone", price: 700),
        Product(id: "macbook", name: "MacBook", price: 1500),
        Product(id: "ipod", name: "iPod", price: 300),
    ]
    
    func products() -> Observable<[Product]> {
        return Observable.deferred {
            return Observable.just(ProductsUseCase._products)
        }
    }
    
    func update(_ product: Product) -> Observable<Void> {
        return Observable.create { observer in
            if let index = ProductsUseCase._products.index(where: { $0.id == product.id }) {
                ProductsUseCase._products[index] = product
                observer.onNext(())
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func add(_ product: Product) -> Observable<Void> {
        return Observable.create { observer in
            ProductsUseCase._products.append(product)
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
