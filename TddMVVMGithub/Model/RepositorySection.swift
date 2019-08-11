//
//  RepositorySection.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources

struct RepositorySection {
    var header: String
    var items: [Item]
}

extension RepositorySection: AnimatableSectionModelType {
    typealias Item = Repository
    init(original: RepositorySection, items: [Item]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}
