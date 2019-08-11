//
//  RepositorySection+Equatable.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
@testable import TddMVVMGithub

extension RepositorySection: Equatable {
    public static func ==(rhs: RepositorySection, lhs: RepositorySection) -> Bool {
        return rhs.items == lhs.items
    }
}
