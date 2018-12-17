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
    
    init<Float: BinaryFloatingPoint>(_ unboxed: Float) {
        self.unboxed = Unboxed(unboxed)
    }
    
    func unbox<Float: BinaryFloatingPoint>() -> Float? {
        return Float(exactly: self.unboxed)
    }
}

extension FloatingPointBox: CustomStringConvertible {
    var description: String {
        return self.unboxed.description
    }
}
