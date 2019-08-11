//
//  GithubSearchViewControllerTest.swift
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

class GithubSearchViewControllerTest: XCTestCase {
    var viewController: GithubSearchViewController!
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
        viewController = GithubSearchViewController(viewModel: viewModel)
        
        // trigger viewDidLoad
        _ = viewController.view
    }
    
    func testPresentCell() {
        let (data, _) = service.setMocking()
        viewModel.searchText.accept("test")
        viewModel.doSearch.accept(())
        testSchduler.start()
        let cell = viewController.dataSource.collectionView(viewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as! RepositoryCell
        XCTAssertEqual(cell.repositoryName.text, data.items.first!.name)
    }
}
