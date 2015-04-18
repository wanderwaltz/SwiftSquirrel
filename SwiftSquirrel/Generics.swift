//
//  Helpers.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 08.04.15.
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

// MARK: - Box<T>
public class Box<T> {
    init(_ value: T) {
        self.value = value
    }
    
    let value: T
}

// MARK: - Result<E,R>
public enum Result<E,R> {
    case Error(Box<E>)
    case Success(Box<R>)
    
    public static func error(payload: E) -> Result<E,R> {
        return .Error(Box<E>(payload))
    }
    
    public static func success(result: R) -> Result<E, R> {
        return .Success(Box<R>(result))
    }
    
    public var error: E? {
        get {
            switch self {
            case let Error(box):
                return box.value
            case let Success(box):
                return nil
            }
        }
    }
    
    public var success: R? {
        get {
            switch self {
            case let Error(box):
                return nil
            case let Success(box):
                return box.value
            }
        }
    }
}


// MARK: - Weak<T>
internal class Weak<T:AnyObject> {
    init(value: T) {
        self.value = value
    }
    
    weak var value: T?
}

// MARK: - function parameter binding
internal func bind<A, B, C>(f: (A, B) -> C, value: B) -> (A) -> C {
    return { (A) -> C in f(A, value) }
}

internal func bind<A, B, C, D>(f: (A, B, C) -> D, value: C) -> (A, B) -> D {
    return { (A, B) -> D in f(A, B, value) }
}