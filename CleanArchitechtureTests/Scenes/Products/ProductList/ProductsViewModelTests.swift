//
//  ProductsViewModelTests.swift
//  CleanArchitechtureTests
//
//  Created by Tuan Truong on 1/12/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import XCTest
import RxBlocking
@testable import CleanArchitechture

class ProductsViewModelTests: XCTestCase {
    
    var viewModel: ProductsViewModel!
    var useCase: ProductsUseCaseMock!
    var navigator: ProductsNavigatorMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        useCase = ProductsUseCaseMock()
        navigator = ProductsNavigatorMock()
        viewModel = ProductsViewModel(useCase: useCase,
                                      navigator: navigator)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_transform_triggerInvoked_products() {
        // arrange
        let trigger = PublishSubject<Void>()
        let input = ProductsViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete(),
                                            createProductTrigger: Driver.empty(),
                                            selection: Driver.empty())
        let output = viewModel.transform(input: input)
        
        // act
        output.products.drive().disposed(by: disposeBag)
        trigger.onNext(())
        let products = try! output.products.toBlocking().first()!
        
        // assert
        XCTAssert(useCase.products_Called)
        XCTAssertEqual(products.count, 1)
    }
    
    func test_transform_createProductTriggerInvoked_toCreateProduct() {
        // arrange
        let createProductTrigger = PublishSubject<Void>()
        let input = ProductsViewModel.Input(trigger: Driver.empty(),
                                            createProductTrigger: createProductTrigger.asDriverOnErrorJustComplete(),
                                            selection: Driver.empty())
        let output = viewModel.transform(input: input)
        
        // act
        output.createProduct.drive().disposed(by: disposeBag)
        createProductTrigger.onNext(())
        
        // assert
        XCTAssert(navigator.toCreateProduct_Called)
    }
    
}
