//
//  GithubViewModel.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel: HasDisposeBag {

    private let service: GithubServiceType
    private let scheduler: RxSchedulerType

    let isLoading = PublishRelay<Bool>()
    let searchText = PublishRelay<String>()
    let sections = PublishRelay<[RepositorySection]>()
    let doSearch = PublishRelay<Void>()
    private var _repositories: [Repository] = []
    
    init(of: GithubServiceType, scheduler: RxSchedulerType) {
        service = of
        self.scheduler = scheduler

        let shareSearchText = searchText.share()

        doSearch
            .observeOn(self.scheduler.main)
            .do(onNext: { [weak isLoading] _ in
                    assertMainThread()
                    isLoading?.accept(true)
                })
            .observeOn(self.scheduler.io)
            .withLatestFrom(shareSearchText)
            .flatMapLatest { [weak service, _repositories] text -> Single<SearchRepositories> in
                assertBackgroundThread()
                return (service?.search(sortOption: SearchOption(query: text)) ?? .never())
                    .debug("search a repositories of Github")
                    .catchError {
                        print("error: \($0)")
                        return Single.just(SearchRepositories(total_count: Int.max, incomplete_results: false, items: _repositories))
                }
            }
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                print("subscribe: \(result)")
                self.isLoading.accept(false)
                self._repositories = result.items
                let section = [RepositorySection(header: "repositories", items: result.items)]
                self.sections.accept(section)
            })
            .disposed(by: disposeBag)
    }

}
