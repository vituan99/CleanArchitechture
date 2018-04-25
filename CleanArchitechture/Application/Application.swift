//
//  Application.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 1/11/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

final class Application {
    static let shared = Application()
    
    private let useCaseProvider: UseCaseProviderType
    
    private init() {
        useCaseProvider = UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let nav = UINavigationController()
        window.rootViewController = nav
        let navigator = ProductsNavigator(navigationController: nav,
                                          useCaseProvider: useCaseProvider)
        navigator.toProducts()
    }
}
