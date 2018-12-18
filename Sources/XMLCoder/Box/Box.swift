//
//  Box.swift
//  XMLCoder
//
//  Created by Vincent Esche on 12/17/18.
//

import Foundation

internal enum Box {
    case null(NullBox)
    case bool(BoolBox)
    case decimal(DecimalBox)
    case signedInteger(SignedIntegerBox)
    case unsignedInteger(UnsignedIntegerBox)
    case floatingPoint(FloatingPointBox)
    case string(StringBox)
    case array(ArrayBox)
    case dictionary(DictionaryBox)
    
    var isNull: Bool {
        guard case .null(_) = self else {
            return false
        }
        return true
    }
    
    var isFragment: Bool {
        switch self {
        case .null(_): return true
        case .bool(_): return true
        case .decimal(_): return true
        case .signedInteger(_): return true
        case .unsignedInteger(_): return true
        case .floatingPoint(_): return true
        case .string(_): return true
        case .array(_): return false
        case .dictionary(_): return false
        }
    }
    
    var bool: BoolBox? {
        guard case .bool(let box) = self else {
            return nil
        }
        return box
    }
    
    var decimal: DecimalBox? {
        guard case .decimal(let box) = self else {
            return nil
        }
        return box
    }
    
    var signedInteger: SignedIntegerBox? {
        guard case .signedInteger(let box) = self else {
            return nil
        }
        return box
    }
    
    var unsignedInteger: UnsignedIntegerBox? {
        guard case .unsignedInteger(let box) = self else {
            return nil
        }
        return box
    }
    
    var floatingPoint: FloatingPointBox? {
        guard case .floatingPoint(let box) = self else {
            return nil
        }
        return box
    }
    
    var string: StringBox? {
        guard case .string(let box) = self else {
            return nil
        }
        return box
    }
    
    var array: ArrayBox? {
        guard case .array(let box) = self else {
            return nil
        }
        return box
    }
    
    var dictionary: DictionaryBox? {
        guard case .dictionary(let box) = self else {
            return nil
        }
        return box
    }
    
    var xmlString: String {
        switch self {
        case .null(let box): return box.xmlString
        case .bool(let box): return box.xmlString
        case .decimal(let box): return box.xmlString
        case .signedInteger(let box): return box.xmlString
        case .unsignedInteger(let box): return box.xmlString
        case .floatingPoint(let box): return box.xmlString
        case .string(let box): return box.xmlString
        case .array(let box): return box.xmlString
        case .dictionary(let box): return box.xmlString
        }
    }
    
    init() {
        self = .null(.init())
    }
    
    init(_ unboxed: Bool) {
        self = .bool(.init(unboxed))
    }
    
    init(_ unboxed: Decimal) {
        self = .decimal(.init(unboxed))
    }
    
    init<Integer: SignedInteger>(_ unboxed: Integer) {
        self = .signedInteger(.init(unboxed))
    }
    
    init<Integer: UnsignedInteger>(_ unboxed: Integer) {
        self = .unsignedInteger(.init(unboxed))
    }
    
    init<Float: BinaryFloatingPoint>(_ unboxed: Float) {
        self = .floatingPoint(.init(unboxed))
    }
    
    init(_ unboxed: String) {
        self = .string(.init(unboxed))
    }
    
    init(_ unboxed: [Box]) {
        self = .array(.init(unboxed))
    }
    
    init(_ unboxed: [String: Box]) {
        self = .dictionary(.init(unboxed))
    }
    
    internal func unbox() throws -> Bool? {
        switch self {
        case .bool(let box): return box.unbox()
        case _: return nil
        }
    }
    
    internal func unbox() throws -> Decimal? {
        switch self {
        case .decimal(let box): return box.unbox()
        case _: return nil
        }
    }
    
    internal func unbox<Integer: BinaryInteger>() throws -> Integer? {
        switch self {
        case .signedInteger(let box): return box.unbox()
        case .unsignedInteger(let box): return box.unbox()
        case _: return nil
        }
    }
    
    internal func unbox<Float: BinaryFloatingPoint & FloatingPoint>() throws -> Float? {
        switch self {
        case .floatingPoint(let box): return box.unbox()
        case _: return nil
        }
    }
    
    internal func unbox() throws -> String? {
        switch self {
        case .string(let box): return box.unbox()
        case _: return nil
        }
    }
    
    internal func unbox() throws -> [Box]? {
        switch self {
        case .array(let box): return box.unbox()
        case _: return nil
        }
    }
    
    internal func unbox() throws -> [String: Box]? {
        switch self {
        case .dictionary(let box): return box.unbox()
        case _: return nil
        }
    }
}

extension Box: Equatable {
    static func == (lhs: Box, rhs: Box) -> Bool {
        switch (lhs, rhs) {
        case (.null(let lhs), .null(let rhs)): return lhs == rhs
        case (.bool(let lhs), .bool(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.decimal(let lhs), .decimal(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.signedInteger(let lhs), .signedInteger(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.unsignedInteger(let lhs), .unsignedInteger(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.floatingPoint(let lhs), .floatingPoint(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.string(let lhs), .string(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.array(let lhs), .array(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.dictionary(let lhs), .dictionary(let rhs)): return lhs.unboxed == rhs.unboxed
        case (.null(_), _): return false
        case (.bool(_), _): return false
        case (.decimal(_), _): return false
        case (.signedInteger(_), _): return false
        case (.unsignedInteger(_), _): return false
        case (.floatingPoint(_), _): return false
        case (.string(_), _): return false
        case (.array(_), _): return false
        case (.dictionary(_), _): return false
        }
    }
}

extension Box: CustomStringConvertible {
    var description: String {
        switch self {
        case .null(let box): return box.description
        case .bool(let box): return box.description
        case .decimal(let box): return box.description
        case .signedInteger(let box): return box.description
        case .unsignedInteger(let box): return box.description
        case .floatingPoint(let box): return box.description
        case .string(let box): return box.description
        case .array(let box): return box.description
        case .dictionary(let box): return box.description
        }
    }
}