//
//  ProductsNavigator.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol ProductsNavigatorType {
    func toProducts()
    func toCreateProduct()
    func toEditProduct(_ product: Product)
}

struct ProductsNavigator: ProductsNavigatorType {
    let navigationController: UINavigationController
    let useCaseProvider: UseCaseProviderType
        
    func toProducts() {
        let vc = ProductsViewController.instantiate()
        let viewModel = ProductsViewModel(useCase: useCaseProvider.makeProductsUseCase(), navigator: self)
        vc.bindViewModel(to: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toCreateProduct() {
        let vc = EditProductViewController.instantiate()
        let viewModel = EditProductViewModel(product: nil,
                                             useCase: useCaseProvider.makeProductsUseCase(),
                                             navigator: EditProductNavigator(navigationController: self.navigationController))
        vc.bindViewModel(to: viewModel)
        let nav = UINavigationController(rootViewController: vc)
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    func toEditProduct(_ product: Product) {
        let vc = EditProductViewController.instantiate()
        let nav = UINavigationController(rootViewController: vc)
        let viewModel = EditProductViewModel(product: product,
                                             useCase: useCaseProvider.makeProductsUseCase(),
                                             navigator: EditProductNavigator(navigationController: nav))
        vc.bindViewModel(to: viewModel)
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    
}
