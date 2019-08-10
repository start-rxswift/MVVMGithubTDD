//
//  GithubServiceType.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubServiceType {
    func search(query: String, sort: String, order: String) -> Single<SearchRepositories>
}
