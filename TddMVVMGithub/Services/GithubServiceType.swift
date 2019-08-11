//
//  GithubServiceType.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubServiceType: class {
    func search(sortOption: SearchOption) -> Single<SearchRepositories>
}
