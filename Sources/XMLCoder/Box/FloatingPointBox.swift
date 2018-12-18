//
//  FloatingPointBox.swift
//  XMLCoder
//
//  Created by Vincent Esche on 12/17/18.
//

import Foundation

internal class FloatingPointBox {
    typealias Unboxed = Float64
    
    let unboxed: Unboxed
    
    var xmlString: String {
        return self.unboxed.description
    }
    
    init<Float: BinaryFloatingPoint>(_ unboxed: Float) {
        self.unboxed = Unboxed(unboxed)
    }
    
    func unbox<Float: BinaryFloatingPoint>() -> Float? {
        return Float(exactly: self.unboxed)
    }
}

extension FloatingPointBox: Equatable {
    static func == (lhs: FloatingPointBox, rhs: FloatingPointBox) -> Bool {
        return lhs.unboxed == rhs.unboxed
    }
}

extension FloatingPointBox: CustomStringConvertible {
    var description: String {
        return self.unboxed.description
    }
}