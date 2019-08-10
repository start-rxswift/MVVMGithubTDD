//
//  GithubServiceTest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
@testable import TddMVVMGithub

class GithubServiceTest: XCTestCase {
    
    var service: GithubService!
    var requests: StubRequests!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        requests = StubRequests()
        service = GithubService(requests: requests, creator: URLRequestCreator())
    }
    
    func testSampleSuccess() {
        
        let response = scheduler.createObserver(SearchRepositories.self)
        service.search(query: "", sort: "", order: "").asObservable().subscribe(response).disposed(by: disposeBag)
        scheduler.start()
        // then
        XCTAssertEqual(response.events, [
            .next(0, Fixture.Repositories.sample),
            .completed(0)
            ])
    }
}


extension SearchRepositories : Equatable {
    public static func == (lhs: SearchRepositories, rhs: SearchRepositories) -> Bool {
        return lhs.total_count == rhs.total_count && lhs.items == rhs.items
    }
}
