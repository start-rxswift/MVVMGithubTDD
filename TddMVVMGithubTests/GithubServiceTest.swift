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
    var requests: MockNetworkRequestProtocol!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        requests = MockNetworkRequestProtocol()
        service = GithubService(scheduler: TestRxScheduler(scheduler),requests: requests, creator: URLRequestMaker())
    }

    func testSampleSuccess() {
        requests.setMocking(data: Fixture.Repositories.sampleData)
        let response = scheduler.createObserver(SearchRepositories.self)
        service.search(sortOption: SearchOption(query: "", sort: "", order: "")).asObservable().subscribe(response).disposed(by: disposeBag)
        scheduler.start()
        // then

        XCTAssertEqual(response.events, [
            .next(0, Fixture.Repositories.sample),
                .completed(0)
            ])
    }
    func testSampleFailture() {
        requests.setMocking(error: RequestsError.failDecoding)
        let response = scheduler.createObserver(SearchRepositories.self)
        service.search(sortOption: SearchOption(query: "", sort: "", order: "")).asObservable().subscribe(response).disposed(by: disposeBag)
        scheduler.start()
        // then
        
        XCTAssertEqual(response.events, [
            .error(0, RequestsError.failDecoding)
            ])
    }
}
