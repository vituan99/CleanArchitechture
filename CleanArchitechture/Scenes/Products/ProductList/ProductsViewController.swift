//
//  ProductsViewController.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, BindableType {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var createButton: UIBarButtonItem!
    
    var viewModel: ProductsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }
    
    fileprivate func configView() {
        tableView.register(cellType: ProductCell.self)
    }

    func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = ProductsViewModel.Input(trigger: viewWillAppear,
                                            createProductTrigger: createButton.rx.tap.asDriver(),
                                            selection: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        output.products.drive(tableView.rx.items(cellIdentifier: ProductCell.className, cellType: ProductCell.self)) { tableView, viewModel, cell in
            cell.bind(viewModel)
            }
            .disposed(by: rx.disposeBag)
        output.selectedProduct
            .drive()
            .disposed(by: rx.disposeBag)
        output.createProduct
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension ProductsViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product.instance
}

