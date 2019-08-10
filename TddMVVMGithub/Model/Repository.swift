//
//  Repository.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct Repository: Decodable, Equatable {
    let id: UInt64
    let name: String
    let owner: Owner
    let full_name: String
    let description: String?
    let url: String
    let stargazers_count: Int
    let forks_count: Int
    let watchers_count: Int
    let open_issues_count: Int
    let score: Float
}

struct Owner: Decodable, Equatable {
    let id: UInt64
    let avatar_url: String
    let url: String
}
