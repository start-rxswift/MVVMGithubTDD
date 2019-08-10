// MARK: - Mocks generated from file: TddMVVMGithub/Services/GithubServiceType.swift at 2019-08-10 12:59:24 +0000

//
//  GithubServiceType.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Cuckoo
@testable import TddMVVMGithub

import Foundation
import RxSwift


 class MockGithubServiceType: GithubServiceType, Cuckoo.ProtocolMock {
    
     typealias MocksType = GithubServiceType
    
     typealias Stubbing = __StubbingProxy_GithubServiceType
     typealias Verification = __VerificationProxy_GithubServiceType

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GithubServiceType?

     func enableDefaultImplementation(_ stub: GithubServiceType) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func search(sortOption: SortOptions) -> Single<SearchRepositories> {
        
    return cuckoo_manager.call("search(sortOption: SortOptions) -> Single<SearchRepositories>",
            parameters: (sortOption),
            escapingParameters: (sortOption),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.search(sortOption: sortOption))
        
    }
    

	 struct __StubbingProxy_GithubServiceType: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable>(sortOption: M1) -> Cuckoo.ProtocolStubFunction<(SortOptions), Single<SearchRepositories>> where M1.MatchedType == SortOptions {
	        let matchers: [Cuckoo.ParameterMatcher<(SortOptions)>] = [wrap(matchable: sortOption) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGithubServiceType.self, method: "search(sortOption: SortOptions) -> Single<SearchRepositories>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GithubServiceType: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func search<M1: Cuckoo.Matchable>(sortOption: M1) -> Cuckoo.__DoNotUse<(SortOptions), Single<SearchRepositories>> where M1.MatchedType == SortOptions {
	        let matchers: [Cuckoo.ParameterMatcher<(SortOptions)>] = [wrap(matchable: sortOption) { $0 }]
	        return cuckoo_manager.verify("search(sortOption: SortOptions) -> Single<SearchRepositories>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GithubServiceTypeStub: GithubServiceType {
    

    

    
     func search(sortOption: SortOptions) -> Single<SearchRepositories>  {
        return DefaultValueRegistry.defaultValue(for: (Single<SearchRepositories>).self)
    }
    
}

