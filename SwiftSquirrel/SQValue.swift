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

public enum SQValue: IntegerLiteralConvertible,
                     FloatLiteralConvertible,
                     BooleanLiteralConvertible,
                     StringLiteralConvertible,
                     Equatable {
    
    case Int(Swift.Int)
    case Float(Swift.Float)
    case Bool(Swift.Bool)
    case String(Swift.String)
    case Null
    
    public init(integerLiteral value: Swift.Int) {
        self = .Int(value)
    }
    
    public init(floatLiteral value: Swift.Float) {
        self = .Float(value)
    }
    
    public init(booleanLiteral value: Swift.Bool) {
        self = .Bool(value)
    }
    
    public init(stringLiteral value: Swift.String){
        self = .String(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: Swift.String){
        self = .String(value)
    }
    
    public init(unicodeScalarLiteral value: Swift.String) {
        self = .String(value)
    }
}

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

