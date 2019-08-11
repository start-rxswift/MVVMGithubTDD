//
//  SortOptions.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct SearchOption: Encodable {
    let query: String
    let sort: String
    let order: String
    
    init(query: String, sort: String = "stars", order: String = "desc") {
        self.query = query
        self.sort = sort
        self.order = order
    }
}
