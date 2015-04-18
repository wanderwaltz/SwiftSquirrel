//
//  SQArray.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 11.04.15.
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

public class SQArray: SQObject, SequenceType, SquirrelCollection, Countable {
    public typealias KeyType = Int
    public typealias ValueType = SQValue
    public typealias Element = (KeyType, ValueType)
    
    // MARK: - SQArray::initializers
    public override init(vm: SquirrelVM) {
        super.init(vm: vm)
        self.obj = vm.object.array()
    }
    
    public init(vm: SquirrelVM, size: Int) {
        super.init(vm: vm)
        self.obj = vm.object.array(size: size)
    }
    
    public override init(vm: SquirrelVM, object obj: HSQOBJECT) {
        super.init(vm: vm, object: obj)
    }
    
    convenience public init(vm: SquirrelVM, object obj: SQObject) {
        self.init(vm: vm, object: obj.obj)
    }
    
    
    // MARK: - SQArray::properties
    public var count: Int {
        get {
            return vm.count(self)
        }
    }
    
    // MARK: - SQArray::methods
    public subscript (key: Int) -> ValueType {
        get {
            return vm.getSlot(self, key: key.asSQValue)
        }
        
        set(value) {
            vm.setSlot(self, key: key.asSQValue, value: value)
        }
    }
    
    // MARK: - SQArray::<SequenceType>
    public func generate() -> ArrayGenerator<SQArray> {
        return vm.generateIndexValuePairs(collection: self)
    }
}