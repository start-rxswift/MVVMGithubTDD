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

    func testLoadingOnSuccess() {
        service.setMocking()
        let isLoading = testSchduler.createObserver(Bool.self)
        viewModel.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)

        viewModel.searchText.accept("test")
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
        verify(service, times(1)).search(sortOption: any())
    }
    func testSections() {
        let (data, _) = service.setMocking()
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

        let expect = [RepositorySection(header: "test", items: data.items)]
        XCTAssertEqual(sections.events, [
            .next(0, expect)
            ])
        
        verify(service, times(1)).search(sortOption: any())
    }
    func testLoadingOnFailure() {
        service.setMocking(error: TestError.test)
        let isLoading = testSchduler.createObserver(Bool.self)
        viewModel.isLoading
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        viewModel.searchText.accept("test")
        testSchduler.createHotObservable([
            .next(0, ()),
            .next(50, ())
            ])
            .bind(to: viewModel.doSearch)
            .disposed(by: disposeBag)
        
        testSchduler.start()
        
        // Error가 발생하면 이벤트가 끊어지는지 체크
        XCTAssertEqual(isLoading.events, [
            .next(0, true),
            .next(0, false),
            .next(50, true),
            .next(50, false)
            ])
        
        verify(service, times(2)).search(sortOption: any())
    }
}
