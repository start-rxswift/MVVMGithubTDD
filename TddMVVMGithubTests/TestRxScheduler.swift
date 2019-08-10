//
//  TestRxScheduler.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
import RxTest
@testable import TddMVVMGithub

class TestRxScheduler: RxSchedulerType {
    var network: SchedulerType
    let io: SchedulerType
    let main: SchedulerType
    
    init(_ scheduler: TestScheduler) {
        self.io = scheduler
        self.main = scheduler
        self.network = scheduler
    }
}
