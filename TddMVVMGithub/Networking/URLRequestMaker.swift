//
//  MakeURLRequest.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
class URLRequestMaker {
    static let DEFAULT_TIMEOUT_SECOND: TimeInterval = 5.0
    
    func get(
        baseUrl: String,
        path: String,
        queryItems: [URLQueryItem]? = nil,
        timeout: TimeInterval = DEFAULT_TIMEOUT_SECOND,
        cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    ) throws -> URLRequest {
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        guard let url = component?.url else {
            throw RequestsError.RequestErrorReason.malformURL(url: component?.url)
        }

        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        return urlRequest
    }

}
