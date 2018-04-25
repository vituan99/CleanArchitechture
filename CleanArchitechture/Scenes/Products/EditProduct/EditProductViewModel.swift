//
//  EditProductViewModel.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/4/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct CustomError: Error, CustomStringConvertible {
    var description: String
}

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
        //Anh nghĩ giá trị không  hợp lệ thì trả nó về dưới dạng 1 lỗi vậy
        // Ở đây nó ko phải lỗi từ API mà lỗi do mình tự xét duyệt nên anh tạm tạo 1 cái errorSubject
        // chú coi chương 3 để biết PublishSubject.
        let errorSubject = PublishSubject<Error>()
        
        let product = Driver.combineLatest(Driver.just(self.product), nameAndPrice) { (product, nameAndPrice) -> Product in
            return Product(id: product?.id ?? UUID().uuidString,
                           name: nameAndPrice.0,
                           price: nameAndPrice.1)
        }
        .startWith(self.product ?? Product(id: "", name: "", price: 0))
        
        let save = input.saveTrigger.withLatestFrom(product)
            .flatMapLatest { product -> Driver<Void> in

                if product.name.isEmpty || product.price == 0 {
                    errorSubject.onNext(CustomError(description: "Gia Tri Khong Hop Le"))
                    return Driver.empty() // trả về empty thì thằng dismiss ở dứoi nó ko bắt đc tín hiệu để thoát khỏi màn hình này
                }

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

        let error = Driver.merge([errorTracker.asDriver(), errorSubject.asDriverOnErrorJustComplete()])
        
        return Output(save: save,
                      dismiss: dismiss,
                      product: product,
                      error: error)
    }
}

