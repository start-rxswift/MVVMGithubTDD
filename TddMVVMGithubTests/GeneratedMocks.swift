// MARK: - Mocks generated from file: TddMVVMGithub/Networking/NetworkRequestProtocol.swift at 2019-08-11 06:30:25 +0000

//
//  NetworkRequestProtocol.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Cuckoo
@testable import TddMVVMGithub

import Foundation
import RxSwift


 class MockNetworkRequestProtocol: NetworkRequestProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = NetworkRequestProtocol
    
     typealias Stubbing = __StubbingProxy_NetworkRequestProtocol
     typealias Verification = __VerificationProxy_NetworkRequestProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: NetworkRequestProtocol?

     func enableDefaultImplementation(_ stub: NetworkRequestProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func request(with: URLRequest) -> Single<Data> {
        
    return cuckoo_manager.call("request(with: URLRequest) -> Single<Data>",
            parameters: (with),
            escapingParameters: (with),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.request(with: with))
        
    }
    

	 struct __StubbingProxy_NetworkRequestProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func request<M1: Cuckoo.Matchable>(with: M1) -> Cuckoo.ProtocolStubFunction<(URLRequest), Single<Data>> where M1.MatchedType == URLRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: with) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkRequestProtocol.self, method: "request(with: URLRequest) -> Single<Data>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_NetworkRequestProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func request<M1: Cuckoo.Matchable>(with: M1) -> Cuckoo.__DoNotUse<(URLRequest), Single<Data>> where M1.MatchedType == URLRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: with) { $0 }]
	        return cuckoo_manager.verify("request(with: URLRequest) -> Single<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkRequestProtocolStub: NetworkRequestProtocol {
    

    

    
     func request(with: URLRequest) -> Single<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Single<Data>).self)
    }
    
}


// MARK: - Mocks generated from file: TddMVVMGithub/Services/GithubServiceType.swift at 2019-08-11 06:30:25 +0000

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
    

    

    

    
    
    
     func search(sortOption: SearchOption) -> Single<SearchRepositories> {
        
    return cuckoo_manager.call("search(sortOption: SearchOption) -> Single<SearchRepositories>",
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
	    
	    
	    func search<M1: Cuckoo.Matchable>(sortOption: M1) -> Cuckoo.ProtocolStubFunction<(SearchOption), Single<SearchRepositories>> where M1.MatchedType == SearchOption {
	        let matchers: [Cuckoo.ParameterMatcher<(SearchOption)>] = [wrap(matchable: sortOption) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGithubServiceType.self, method: "search(sortOption: SearchOption) -> Single<SearchRepositories>", parameterMatchers: matchers))
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
	    func search<M1: Cuckoo.Matchable>(sortOption: M1) -> Cuckoo.__DoNotUse<(SearchOption), Single<SearchRepositories>> where M1.MatchedType == SearchOption {
	        let matchers: [Cuckoo.ParameterMatcher<(SearchOption)>] = [wrap(matchable: sortOption) { $0 }]
	        return cuckoo_manager.verify("search(sortOption: SearchOption) -> Single<SearchRepositories>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GithubServiceTypeStub: GithubServiceType {
    

    

    
     func search(sortOption: SearchOption) -> Single<SearchRepositories>  {
        return DefaultValueRegistry.defaultValue(for: (Single<SearchRepositories>).self)
    }
    
}

