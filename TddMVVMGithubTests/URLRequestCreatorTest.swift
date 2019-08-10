//
//  URLRequestCreatorTest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest
@testable import TddMVVMGithub

class URLRequestCreatorTest: XCTestCase {
    
    func testCreateURLRequest() {
        let result = try! URLRequestCreator().makeGetURLRequest(baseUrl: "https://test.com", path: "/rra")
        XCTAssertEqual(result.url!.absoluteString, "https://test.com/rra")
    }
    func testCreateURLRequestWithQueryItems() {
        let result = try! URLRequestCreator().makeGetURLRequest(baseUrl: "https://test.com", path: "/rra", queryItems: [URLQueryItem(name: "test", value: "tt")])
        XCTAssertEqual(result.url!.absoluteString, "https://test.com/rra?test=tt")
    }
}

