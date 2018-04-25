//
//  EditProductViewModel.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/4/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct EditProductViewModel: ViewModelType {
    
    struct Input {
        let saveTrigger: Driver<Void>
        let cancelTrigger: Driver<Void>
        let name: Driver<String>
        let price: Driver<Double>
    }
    
    struct Output {
        let save: Driver<Void>
        let dismiss: Driver<Void>
        let product: Driver<Product>
        let error: Driver<Error>
    }
    
    let product: Product?
    let useCase: ProductsUseCaseType
    let navigator: EditProductNavigatorType
    
    var editingProduct: Bool {
        return product != nil
    }
    
    func transform(input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let nameAndPrice = Driver.combineLatest(input.name, input.price)
        
        let product = Driver.combineLatest(Driver.just(self.product), nameAndPrice) { (product, nameAndPrice) -> Product in
            return Product(id: product?.id ?? UUID().uuidString,
                           name: nameAndPrice.0,
                           price: nameAndPrice.1)
        }
        .startWith(self.product ?? Product(id: "", name: "", price: 0))
        
        let save = input.saveTrigger.withLatestFrom(product)
            .flatMapLatest { product -> Driver<Void> in
                if self.editingProduct {
                    return self.useCase.update(product)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                } else {
                    return self.useCase.add(product)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }
            }
        
        let dismiss = Driver.of(save, input.cancelTrigger)
            .merge()
            .do(onNext: navigator.toProducts)
        
        return Output(save: save,
                      dismiss: dismiss,
                      product: product,
                      error: errorTracker.asDriver())
    }
}

