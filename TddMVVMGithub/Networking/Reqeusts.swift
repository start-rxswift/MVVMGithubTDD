//
//  Reqeusts.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

// https://github.com/ReactiveX/RxSwift/blob/master/RxCocoa/Foundation/URLSession%2BRx.swift
class Requests: NetworkRequestProtocol {

    static let shared = Requests()
    private let session = URLSession.shared
    
    private init() { }

    func request(with: URLRequest) -> Single<Data> {
        return Single.create { [weak session] single in
            HTTPLog.log(request: with)
            guard let session = session else { return Disposables.create() }
            let task = session.dataTask(with: with) { data, response, error in
                defer { HTTPLog.log(data: data, response: response, error: error) }
                guard let response = response, let data = data else {
                    single(.error(RequestsError.ResponseErrorReason.noURLResponse))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.error(RequestsError.ResponseErrorReason.invalidURLResponse(response: response)))
                    return
                }

                if 200 ..< 300 ~= httpResponse.statusCode {
                    single(.success(data))
                } else {
                    single(.error(RequestsError.ResponseErrorReason.invalidHTTPStatusCode(response: httpResponse)))
                }
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
}
