//
//  Fixture.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
@testable import TddMVVMGithub

struct Fixture {
    struct Repositories {
        static let sample: [Repository] = ResourcesLoader.loadJson("sample")
    }
}
