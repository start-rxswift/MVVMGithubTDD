//
//  Encodable+Dict.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension Encodable {
    func tryAsDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    func tryQueryItem() throws -> [URLQueryItem] {
        let dictionary = try tryAsDictionary()
        return dictionary.map {
            URLQueryItem(name: $0, value: String(describing: $1))
        }
    }
}
