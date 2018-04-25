//
//  ProductsUseCaseType.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

protocol ProductsUseCaseType {
    func products() -> Observable<[Product]>
    func update(_ product: Product) -> Observable<Void>
    func add(_ product: Product) -> Observable<Void>
}
