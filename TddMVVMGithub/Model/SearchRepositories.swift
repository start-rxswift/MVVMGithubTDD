//
//  SearchRepositories.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct SearchRepositories: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]
}
