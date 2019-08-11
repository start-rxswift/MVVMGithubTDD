//
//  MakeURLRequest.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
class URLRequestBuilder {
    static let DEFAULT_TIMEOUT_SECOND: TimeInterval = 5.0

    static func get(
        baseUrl: String
    ) -> GetBuilder {
        return GetBuilder(baseUrl: baseUrl)
    }

    class GetBuilder {

        var urlComponent: URLComponents?

        internal init(baseUrl: String) {
            urlComponent = URLComponents(string: baseUrl)
        }

        func path(_ path: String) -> GetBuilder {
            self.urlComponent?.path = path
            return self
        }
        func queryItems(_ queryItems: [URLQueryItem]) -> GetBuilder {
            self.urlComponent?.queryItems = queryItems
            return self
        }
        func build(
            timeout: TimeInterval = DEFAULT_TIMEOUT_SECOND,
            cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalCacheData
        ) throws -> URLRequest {
            guard let url = urlComponent?.url else { throw RequestsError.RequestErrorReason.malformURL(url: urlComponent?.url) }
            var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
    }
}
