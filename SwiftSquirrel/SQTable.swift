//
//  SQTable.swift
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

public class SQTable: SQObject, SequenceType, SquirrelCollection {
    public typealias KeyType = SQValue
    public typealias ValueType = SQValue
    public typealias Element = (KeyType, ValueType)

    // MARK: - SQTable::initializers
    public override init(vm: SquirrelVM) {
        super.init(vm: vm)
        vm.perform { (let vm) in
            sq_newtable(vm)
            sq_getstackobj(vm, -1, &self.obj)
            sq_addref(vm, &self.obj)
        }
    }
    
    public override init(vm: SquirrelVM, object obj: HSQOBJECT) {
        super.init(vm: vm, object: obj)
    }
    
    convenience public init(vm: SquirrelVM, object obj: SQObject) {
        self.init(vm: vm, object: obj.obj)
    }
    
    
    // MARK: - SQTable::methods
    public subscript (position: KeyType) -> ValueType {
        get {
            // TODO: implement
            return .Null
        }
    }
    
    // MARK: - SQTable::<SequenceType>
    public func generate() -> KeyValueGenerator<SQTable> {
        return vm.generateKeyValuePairs(collection: self)
    }
}