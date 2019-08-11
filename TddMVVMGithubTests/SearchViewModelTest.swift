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
import Cuckoo
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
                .next(0, ())
            ])
            .bind(to: viewModel.doSearch)
            .disposed(by: disposeBag)

        testSchduler.start()

        XCTAssertEqual(isLoading.events, [
                .next(0, true),
                .next(0, false)
            ])
    }
    func testSections() {
        let mockData = service.setMocking()
        let sections = testSchduler.createObserver([RepositorySection].self)
        viewModel.sections
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        viewModel.searchText.accept("test")
        testSchduler.createHotObservable([
            .next(0, ())
            ])
            .bind(to: viewModel.doSearch)
            .disposed(by: disposeBag)
        
        testSchduler.start()

        let expect = [RepositorySection(header: "test", items: try! mockData.get().items)]
        XCTAssertEqual(sections.events, [
            .next(0, expect)
            ])
        
        verify(service, times(1)).search(sortOption: any())
    }
}

import RxDataSources

struct RepositorySection {
    var header: String
    var items: [Item]
}

extension RepositorySection: AnimatableSectionModelType {
    typealias Item = Repository
    init(original: RepositorySection, items: [Item]) {
        self = original
        self.items = items
    }

    var identity: String {
        return header
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
    let sections = PublishRelay<[RepositorySection]>()
    let doSearch = PublishRelay<Void>()
    
    init(of: GithubServiceType, scheduler: RxSchedulerType) {
        service = of
        self.scheduler = scheduler

        let shareSearchText = searchText.share()
        
        doSearch
            .observeOn(self.scheduler.main)
            .do(
                onNext: { [weak isLoading] _ in
                    assertMainThread()
                    isLoading?.accept(true)
                },
                afterNext: { [weak isLoading] _ in
                    assertMainThread()
                    isLoading?.accept(false)
                })
            .withLatestFrom(shareSearchText)
            .flatMapLatest { [weak service] text -> Single<SearchRepositories> in
                assertBackgroundThread()
                return service?.search(sortOption: SearchOption(query: text)) ?? .never()
            }
            .subscribe(onNext: { [weak sections] result in
                let section = [RepositorySection(header: "repositories", items: result.items)]
                sections?.accept(section)
            })
            .disposed(by: disposeBag)
    }
}
