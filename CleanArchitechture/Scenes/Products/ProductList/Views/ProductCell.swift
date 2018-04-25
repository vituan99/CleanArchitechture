//
//  ProductCell.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/4/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell, NibReusable {

    func bind(_ viewModel: ProductItemViewModel) {
        self.textLabel?.text = viewModel.name
        self.detailTextLabel?.text = viewModel.price.toCurrency()
    }
}
