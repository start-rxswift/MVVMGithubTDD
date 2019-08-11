//
//  GithubService.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

class GithubService: GithubServiceType {
    static let BASE_URL = "https://api.github.com/"
    let timeoutInterval = 5.0
    private let requests: NetworkRequestProtocol
    private let scheduler: RxSchedulerType

    init(
        scheduler: RxSchedulerType,
        requests: NetworkRequestProtocol
    ) {
        self.requests = requests
        self.scheduler = scheduler
    }

    convenience init(scheduler: RxSchedulerType) {
        self.init(scheduler: scheduler, requests: Requests.shared)
    }
    
    func search(sortOption: SearchOption) -> Single<SearchRepositories> {
        let path = "/search/repositories"
        return Single
            .deferred {
                var urlRequest: URLRequest
                do {
                    urlRequest = try URLRequestBuilder
                        .get(baseUrl: GithubService.BASE_URL)
                        .path(path)
                        .queryItems(sortOption.tryQueryItem())
                        .build()
                    urlRequest.addValue("", forHTTPHeaderField: "User-Agent")
                } catch {
                    return Single.error(error)
                }
                return self.requests.request(with: urlRequest)
                    .map(SearchRepositories.self)
            }
            .subscribeOn(self.scheduler.network)
    }
}
