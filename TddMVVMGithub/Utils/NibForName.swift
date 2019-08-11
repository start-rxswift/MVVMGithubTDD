//
//  NibForName.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import Foundation
import UIKit
protocol NibForName: SwiftNameIdentifier {
    static var nib: UINib { get }
}
extension NibForName {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}
