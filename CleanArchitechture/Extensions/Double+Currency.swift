//
//  Double+Currency.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/4/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

extension Double {
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
