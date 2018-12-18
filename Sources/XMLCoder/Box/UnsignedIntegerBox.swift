//
//  UnsignedIntegerBox.swift
//  XMLCoder
//
//  Created by Vincent Esche on 12/17/18.
//

import Foundation

internal class UnsignedIntegerBox {
    typealias Unboxed = Int
    
    let unboxed: Unboxed
    
    var xmlString: String {
        return self.unboxed.description
    }
    
    init<Integer: UnsignedInteger>(_ unboxed: Integer) {
        self.unboxed = Unboxed(unboxed)
    }
    
    func unbox<Integer: BinaryInteger>() -> Integer? {
        return Integer(exactly: self.unboxed)
    }
}

extension UnsignedIntegerBox: Equatable {
    static func == (lhs: UnsignedIntegerBox, rhs: UnsignedIntegerBox) -> Bool {
        return lhs.unboxed == rhs.unboxed
    }
}

extension UnsignedIntegerBox: CustomStringConvertible {
    var description: String {
        return self.unboxed.description
    }
}