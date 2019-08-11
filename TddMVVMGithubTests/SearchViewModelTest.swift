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
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        service = MockGithubServiceType()
        testSchduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        viewModel = SearchViewModel(of: service, scheduler: TestRxScheduler(testSchduler))
    }

    func testIsLoading() {
        service.setMocking()
        let isLoading = testSchduler.createObserver(Bool.self)
        viewModel.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)

        testSchduler.createHotObservable([
                .next(0, "loading")
            ])
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        testSchduler.start()

        XCTAssertEqual(isLoading.events, [
                .next(0, true),
                .next(0, false)
            ])
    }
}


import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: HasDisposeBag {

    private let service: GithubServiceType
    private let scheduler: RxSchedulerType

    let isLoading = PublishRelay<Bool>()
    let searchText = PublishRelay<String>()

    init(of: GithubServiceType, scheduler: RxSchedulerType) {
        service = of
        self.scheduler = scheduler

        searchText
            .do(
                onNext: { [weak isLoading] _ in
                    isLoading?.accept(true)
                },
                afterNext: { [weak isLoading] _ in
                    isLoading?.accept(false)
                })
            .flatMapLatest { [weak service] text -> Single<SearchRepositories> in
                service?.search(sortOption: SearchOption(query: text)) ?? .never()
            }
            .subscribe(onNext: { result in

            })
            .disposed(by: disposeBag)
    }
}
