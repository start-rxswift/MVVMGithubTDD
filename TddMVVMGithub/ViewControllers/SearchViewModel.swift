//
//  GithubViewModel.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    private let service: GithubServiceType
    private let scheduler: RxSchedulerType
    
    init(of: GithubServiceType, scheduler: RxSchedulerType) {
        service = of
        self.scheduler = scheduler
    }
}
