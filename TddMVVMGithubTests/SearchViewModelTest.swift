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
