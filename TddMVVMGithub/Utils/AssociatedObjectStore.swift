//
//  AssociatedObjectStore.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import ObjectiveC

public protocol AssociatedObjectStore {
}

extension AssociatedObjectStore {
    func synchronized<T>(_ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }
    
    private func associatedObject<T>(forKey key: UnsafeRawPointer) -> T? {
        return synchronized {
            return objc_getAssociatedObject(self, key) as? T
        }
    }
    
    func associatedObject<T>(forKey key: UnsafeRawPointer, default: @autoclosure () -> T) -> T {
        if let object: T = self.associatedObject(forKey: key) {
            return object
        }
        let object = `default`()
        self.setAssociatedObject(object, forKey: key)
        return object
    }
    
    func setAssociatedObject<T>(_ object: T?, forKey key: UnsafeRawPointer) {
        return synchronized {
            return objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
