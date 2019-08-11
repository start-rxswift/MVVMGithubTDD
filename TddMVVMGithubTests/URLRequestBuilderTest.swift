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

class URLRequestBuilderTest: XCTestCase {
    
    func testURLReqeust() {
        let result = try! URLRequestBuilder
            .get(baseUrl: "https://test.com")
            .path("/rra")
            .build()
        XCTAssertEqual(result.url!.absoluteString, "https://test.com/rra")
    }
    func testURLReqeustWithQueryItems() {
        let result = try! URLRequestBuilder
            .get(baseUrl: "https://test.com")
            .path("/rra")
            .queryItems([URLQueryItem(name: "test", value: "tt")])
            .build()
        XCTAssertEqual(result.url!.absoluteString, "https://test.com/rra?test=tt")
    }
}

