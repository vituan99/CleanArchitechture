//
//  EditProductNavigator.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/5/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol EditProductNavigatorType {
    func toProducts()
}

struct EditProductNavigator: EditProductNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toProducts() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
