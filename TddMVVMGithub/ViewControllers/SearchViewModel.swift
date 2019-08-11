//
//  GithubViewModel.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//


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
