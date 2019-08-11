//
//  SearchViewModelTest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
import RxTest
import XCTest
@testable import TddMVVMGithub

class SearchViewModelTest: XCTestCase {
    
    var viewModel: SearchViewModel!
    var service: MockGithubServiceType!
    var testSchduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        service = MockGithubServiceType()
        testSchduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        viewModel = SearchViewModel(of: service, scheduler: TestRxScheduler(testSchduler))
    }
    
    func testIsLoading() {
    }
}
