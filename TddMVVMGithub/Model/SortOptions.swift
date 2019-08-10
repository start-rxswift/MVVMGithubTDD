//
//  SortOptions.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct SortOptions: Encodable {
    let query: String
    let sort: String
    let order: String
}
