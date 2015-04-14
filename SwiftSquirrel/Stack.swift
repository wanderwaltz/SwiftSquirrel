//
//  VMStack.swift
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

public protocol Stack: class {
    var top: Int { get set }
    
    func pop(count: Int)
    
    // MARK: - push functions
    func push(x: SQValueConvertible)
    
    // MARK: - reading functions
    subscript(position: Int) -> SQValue { get }
    
    func integer(at position: Int) -> Int?
    func float(at position: Int) -> Double?
    func bool(at position: Int) -> Bool?
    func string(at position: Int) -> String?
    
    func object(at position: Int) -> SQObject?
    func table(at position: Int) -> SQTable?
}

public func << (stack: Stack, x: SQValue) -> Stack {
    stack.push(x)
    return stack
}

public func << (stack: Stack, x: SQValueConvertible) -> Stack {
    stack.push(x)
    return stack
}