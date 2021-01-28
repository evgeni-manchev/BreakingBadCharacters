//
//  Withable.swift
//  BreakingBadCharacters
//
//  Created by Evgeni Manchev on 28.01.21.
//

import UIKit

public protocol Withable {
    
    associatedtype T
    
    @discardableResult func with(_ closure: (_ instance: T) -> Void) -> T
}

public extension Withable {

    @discardableResult func with(_ closure: (_ instance: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Withable { }
