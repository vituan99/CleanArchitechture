//
//  EditProductViewController.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/4/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class EditProductViewController: UIViewController, BindableType {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var viewModel: EditProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let product = viewModel.product {
            title = product.name
            nameTextField.text = product.name
            priceTextField.text = String(product.price)
        }
    }
    
    deinit {
        print("EditProductViewController deinit")
    }
    
    func bindViewModel() {
        let input = EditProductViewModel.Input(saveTrigger: saveButton.rx.tap.asDriver(),
                                               cancelTrigger: cancelButton.rx.tap.asDriver(),
                                               name: nameTextField.rx.text.orEmpty.asDriver(),
                                               price: priceTextField.rx.text.orEmpty.map { Double($0) ?? 0 }
                                                    .asDriver(onErrorJustReturn: 0))
        let output = viewModel.transform(input: input)
        output.save
            .drive()
            .disposed(by: rx.disposeBag)
        output.dismiss
            .drive()
            .disposed(by: rx.disposeBag)
        output.product
            .drive(postBinding)
            .disposed(by: rx.disposeBag)
        output.error
            .drive(errorBinding)
            .disposed(by: rx.disposeBag)
        output.validProduct
            .drive(validProductBinding)
            .disposed(by: rx.disposeBag)
        
    }

    var validProductBinding: Binder<Bool> {
        return Binder(self, binding: { (vc, valid) in
            if !valid {
                vc.showAlert(message: "Gia tri khong hop le")
            }
        })
    }
    
    var postBinding: Binder<Product> {
        return Binder(self, binding: { (vc, product) in
            vc.title = product.name
        })
    }
    
    var errorBinding: Binder<Error> {
        return Binder(self, binding: { (vc, _) in
            let alert = UIAlertController(title: "Save Error",
                                          message: "Something went wrong",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss",
                                       style: UIAlertActionStyle.cancel,
                                       handler: nil)
            alert.addAction(action)
            vc.present(alert, animated: true, completion: nil)
        })
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel",
                                   style: UIAlertActionStyle.cancel,
                                   handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - StoryboardSceneBased
extension EditProductViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.product.instance
}

