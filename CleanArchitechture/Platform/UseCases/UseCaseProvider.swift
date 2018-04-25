//
//  UseCaseProvider.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/4/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct UseCaseProvider: UseCaseProviderType {
    func makeProductsUseCase() -> ProductsUseCaseType {
        return ProductsUseCase()
    }
}
