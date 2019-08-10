//
//  Data+Decode.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

extension Data {
    func decode<D: Decodable>(_ type: D.Type) throws -> D {
        let object = try JSONDecoder().decode(D.self, from: self)
        return object
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Data {
    public func map<D: Decodable>(_ type: D.Type) -> Single<D> {
        return self.map { try $0.decode(type) }
    }
}
