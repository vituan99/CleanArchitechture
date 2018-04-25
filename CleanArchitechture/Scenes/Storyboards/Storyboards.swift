//
//  Storyboards.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case product = "Product"
}

extension Storyboards {
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
