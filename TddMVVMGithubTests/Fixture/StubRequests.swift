
//
//  StubRequest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
@testable import TddMVVMGithub

class StubRequests: NetworkRequestProtocol {
    func request(with: URLRequest) -> Single<Data> {
        return Single.just(Fixture.Repositories.sampleData)
    }
}
