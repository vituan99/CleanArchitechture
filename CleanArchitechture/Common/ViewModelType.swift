//
//  ViewModelType.swift
//  CleanArchitechture
//
//  Created by Tuan Truong on 12/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
