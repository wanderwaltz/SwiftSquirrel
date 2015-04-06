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

public enum SQValue: Hashable {
    
    case Int(Swift.Int)
    case Float(Swift.Float)
    case Bool(Swift.Bool)
    case String(Swift.String)
    case Object(SQObject)
    case Null
    
    // MARK: - SQValue::conversions
    public var asFloat: Swift.Float? {
        get {
            switch (self) {
            case let .Float(value):
                return value
            case let .Int(value):
                return Swift.Float(value)
            default:
                return nil
            }
        }
    }
    
    public var asInt: Swift.Int? {
        get {
            switch (self) {
            case let .Float(value):
                return Swift.Int(value)
            case let .Int(value):
                return value
            default:
                return nil
            }
        }
    }
    
    public var asBool: Swift.Bool? {
        get {
            switch (self) {
            case let .Bool(value):
                return value
            default:
                return nil
            }
        }
    }
    
    public var asString: Swift.String? {
        get {
            switch (self) {
            case let .String(value):
                return value
            default:
                return nil
            }
        }
    }
    
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
    
    // MARK: - SQValue::<Hashable>
    public var hashValue: Swift.Int {
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
    case (.Null, .Null): return true
    default: return false
    }
}


public func + (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a+b)
    case (.Float(let a), .Int(let b)): return .Float(a+Float(b))
    case (.Int(let a), .Float(let b)): return .Float(Float(a)+b)
    case (.String(let a), .String(let b)): return .String(a+b)
        
    default:
        return .Null
    }
}


public func - (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a-b)
    case (.Float(let a), .Int(let b)): return .Float(a-Float(b))
    case (.Int(let a), .Float(let b)): return .Float(Float(a)-b)
        
    default:
        return .Null
    }
}


public func * (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a*b)
    case (.Float(let a), .Int(let b)): return .Float(a*Float(b))
    case (.Int(let a), .Float(let b)): return .Float(Float(a)*b)
        
    default:
        return .Null
    }
}


public func / (left: SQValue, right: SQValue) -> SQValue {
    switch (left, right) {
    case (.Int(let a), .Int(let b)): return .Int(a/b)
    case (.Float(let a), .Int(let b)): return .Float(a/Float(b))
    case (.Int(let a), .Float(let b)): return .Float(Float(a)/b)
        
    default:
        return .Null
    }
}

