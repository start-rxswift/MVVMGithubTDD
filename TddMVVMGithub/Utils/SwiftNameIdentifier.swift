//
//  SwiftNameIdentifier.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//


protocol SwiftNameIdentifier {
    static var swiftIdentifier: String { get }
}
extension SwiftNameIdentifier {
    static var swiftIdentifier: String {
        return String(describing: Self.self)
    }
}
