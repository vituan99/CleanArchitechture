//
//  ProductsViewModel.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct ProductsViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let createProductTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let products: Driver<[ProductItemViewModel]>
        let createProduct: Driver<Void>
        let selectedProduct: Driver<Product>
        let error: Driver<Error>
    }
    
    let useCase: ProductsUseCaseType
    let navigator: ProductsNavigatorType
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let products = input.trigger
            .flatMapLatest {
                return self.useCase.products()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
                    .map { $0.map { ProductItemViewModel(with: $0) } }
            }
       
        let selectedProduct = input.selection
            .withLatestFrom(products) { (indexPath, products) -> Product in
                let product = products[indexPath.row].product
                print(product.name)
                return product
            }
            .do(onNext: navigator.toEditProduct)
        
        let createProduct = input.createProductTrigger
            .do(onNext: navigator.toCreateProduct)
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(fetching: fetching,
                      products: products,
                      createProduct: createProduct,
                      selectedProduct: selectedProduct,
                      error: errors)
    }
}
