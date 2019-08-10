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
    private  let requests: NetworkRequestProtocol
    private let requestCreator: URLRequestCreator
    
    init(requests: NetworkRequestProtocol, creator: URLRequestCreator) {
        self.requests = requests
        self.requestCreator = creator
    }

    func search(query: String, sort: String, order: String) -> Single<SearchRepositories> {
        let path = "/search/repositories"
        let urlRequest: URLRequest
        do {
            urlRequest = try requestCreator.makeGetURLRequest(baseUrl: GithubService.BASE_URL, path: path)
        } catch {
            return Single.error(error)
        }
        return self.requests.request(with: urlRequest)
            .map(SearchRepositories.self)
    }
}
