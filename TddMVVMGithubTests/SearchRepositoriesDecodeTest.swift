//
//  RepositoryDecodeTest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest
@testable import TddMVVMGithub

class SearchRepositoriesDecodeTest: XCTestCase {

    func testDecode() {
        let sample = ResourcesLoader.readData("sample", ofType: "json")
        var result: SearchRepositories?
        do {
            result = try JSONDecoder().decode(SearchRepositories.self, from: sample)
        } catch {
            print("\(#function) \(#line) : catchs \(error)")
        }
        XCTAssertNotNil(result)
    }
}
