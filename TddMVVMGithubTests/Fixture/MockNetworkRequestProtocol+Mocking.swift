//
//  MockNetworkRequestProtocol+Mocking.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Cuckoo
import RxSwift
@testable import TddMVVMGithub

extension MockNetworkRequestProtocol {
    func setMocking(data: Data? = nil, error: Error? = nil) {
        stub(self, block: { mock in
            let mockData = data ?? Fixture.Repositories.sampleData

            when(mock.request(with: any()))
                .then { _ in
                    Single.just(mockData)
                        .map {
                            if let error = error {
                                throw error
                            } else {
                                return $0
                            }
                    }
            }
        })
    }
}
