//
//  Value.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 06.04.15.
//  Copyright (c) 2015  Egor Chiglintsev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import CSquirrel

public enum SQValue {
    public typealias IntType = Swift.Int
    public typealias FloatType = Swift.Double
    public typealias BoolType = Swift.Bool
    public typealias StringType = Swift.String
    
    case Int(IntType)
    case Float(FloatType)
    case Bool(BoolType)
    case String(StringType)
    case Object(SQObject)
    case Null
}


// MARK: - SQValue::<DebugPrintable>
extension SQValue: DebugPrintable {
    public var debugDescription: Swift.String {
        get {
            switch (self) {
            case let Int(value):
                return "Int(\(value))"
            case let Float(value):
                return "Float(\(value))"
            case let Bool(value):
                return "Bool(\(value))"
            case let String(value):
                return "String(\(value))"
            case let Object(value):
                return "Object(\(value))"
            case Null:
                return "Null"
            }
        }
    }
}


// MARK: - SQValue::<Hashable>
extension SQValue: Hashable {
    public var hashValue: IntType {
        get {
            switch (self) {
            case let .Int(value):
                return value.hashValue
            case let .Float(value):
                return value.hashValue
            case let .Bool(value):
                return value.hashValue
            case let .String(value):
                return value.hashValue
            case let .Object(obj):
                return Swift.Int(obj.obj._type.value)
            case .Null:
                return 0
            }
        }
    }
}


// MARK: - SQValue::operators
public func ==(left: SQValue, right: SQValue) -> Bool {
    switch (left, right) {
    case (.Int(let a), .Int(let b)) where a == b: return true
    case (.Float(let a), .Float(let b)) where a == b: return true
    case (.Bool(let a), .Bool(let b)) where a == b: return true
    case (.String(let a), .String(let b)) where a == b: return true
    case (.Object(let a), .Object(let b)) where a == b: return true
    case (.Null, .Null): return true
    default: return false
    }
}


public func + (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a+b)
    case (.Float(let a), .Int(let b)): return .Float(a+SQValue.FloatType(b))
    case (.Int(let a), .Float(let b)): return .Float(SQValue.FloatType(a)+b)
    case (.String(let a), .String(let b)): return .String(a+b)
        
    default:
        return .Null
    }
}


public func - (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a-b)
    case (.Float(let a), .Int(let b)): return .Float(a-SQValue.FloatType(b))
    case (.Int(let a), .Float(let b)): return .Float(SQValue.FloatType(a)-b)
        
    default:
        return .Null
    }
}


public func * (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a*b)
    case (.Float(let a), .Int(let b)): return .Float(a*SQValue.FloatType(b))
    case (.Int(let a), .Float(let b)): return .Float(SQValue.FloatType(a)*b)
        
    default:
        return .Null
    }
}


public func / (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a/b)
    case (.Float(let a), .Int(let b)): return .Float(a/SQValue.FloatType(b))
    case (.Int(let a), .Float(let b)): return .Float(SQValue.FloatType(a)/b)
        
    default:
        return .Null
    }
}


// MARK: - SQValueConvertible
public protocol SQValueConvertible {
    var asSQValue: SQValue { get }
}

extension SQValue: SQValueConvertible {
    public var asSQValue: SQValue {
        get {
            return self
        }
    }
}


// MARK: - SQValue <-> Int
extension SQValue: IntegerLiteralConvertible {
    public init(integerLiteral value: IntType) {
        self = .Int(value)
    }
    
    public var asInt: IntType? {
        get {
            switch (self) {
            case let .Float(value):
                return IntType(value)
            case let .Int(value):
                return value
            default:
                return nil
            }
        }
    }
}

extension Int: SQValueConvertible {
    public var asSQValue: SQValue {
        get {
            return SQValue.Int(self)
        }
    }
}


// MARK: - SQValue <-> Double
extension SQValue: FloatLiteralConvertible {
    public init(floatLiteral value: FloatType) {
        self = .Float(value)
    }
    
    public var asFloat: FloatType? {
        get {
            switch (self) {
            case let .Float(value):
                return value
            case let .Int(value):
                return FloatType(value)
            default:
                return nil
            }
        }
    }
}

extension Double: SQValueConvertible {
    public var asSQValue: SQValue {
        get {
            return SQValue.Float(self)
        }
    }
}


// MARK: - SQValue <-> Bool
extension SQValue: BooleanLiteralConvertible {
    public init(booleanLiteral value: BoolType) {
        self = .Bool(value)
    }
    
    public var asBool: BoolType? {
        get {
            switch (self) {
            case let .Bool(value):
                return value
            default:
                return nil
            }
        }
    }
}

extension Bool: SQValueConvertible {
    public var asSQValue: SQValue {
        get {
            return SQValue.Bool(self)
        }
    }
}


// MARK: - SQValue <-> String
extension SQValue: StringLiteralConvertible {
    public init(stringLiteral value: StringType) {
        self = .String(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringType) {
        self = .String(value)
    }
    
    public init(unicodeScalarLiteral value: StringType) {
        self = .String(value)
    }
    
    public var asString: StringType? {
        get {
            switch (self) {
            case let .String(value):
                return value
            default:
                return nil
            }
        }
    }
}

extension String: SQValueConvertible {
    public var asSQValue: SQValue {
        get {
            return SQValue.String(self)
        }
    }
}

// MARK: - SQValue <-> SQObject
extension SQValue {
    public var asObject: SQObject? {
        get {
            switch (self) {
            case let .Object(value):
                return value
            default:
                return nil
            }
        }
    }
    
    public var asTable: SQTable? {
        get {
            switch (self) {
            case let .Object(value):
                if value.obj._type.value == OT_TABLE.value {
                    return SQTable(vm: value.vm, object: value.obj)
                }
                else {
                    return nil
                }
            default:
                return nil
            }
        }
    }
    
    public var asArray: SQArray? {
        get {
            switch self {
            case let .Object(value):
                if value.obj._type.value == OT_ARRAY.value {
                    return SQArray(vm: value.vm, object: value.obj)
                }
                else {
                    return nil
                }
            default:
                return nil
            }
        }
    }
}

extension SQObject: SQValueConvertible {
    public var asSQValue: SQValue {
        get {
            return SQValue.Object(self)
        }
    }
}


// MARK: - SQValue <-> Nil
extension SQValue: NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self = .Null
    }
}