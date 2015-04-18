//
//  SQClosure.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 19.04.15.
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

public class SQClosure: SQObject {
    // MARK: - initializers
    internal override init(vm: SquirrelVM, object obj: HSQOBJECT) {
        super.init(vm: vm, object: obj)
    }
    
    convenience public init(vm: SquirrelVM, object obj: SQObject) {
        self.init(vm: vm, object: obj.obj)
    }
    
    
    // MARK: - calls
    public func call(parameters: SQValueConvertible...) -> SQValue {
        return call(parameters)
    }
    
    public func call(parameters: [SQValueConvertible]) -> SQValue {
        return call(this: vm.rootTable, parameters: parameters)
    }
    
    
    public func call(#this: SQObject, parameters: SQValueConvertible...) -> SQValue {
        return call(this: this, parameters: parameters)
    }
    
    public func call(#this: SQObject, parameters: [SQValueConvertible]) -> SQValue {
        let top = vm.stack.top
        
        vm.stack << .Null
        vm.stack << self
        vm.stack << this
        
        for param in parameters {
            vm.stack << param
        }
        
        // Parameters count is at least 1 since the first parameter is
        // always the 'this' object.
        //
        // First SQBool is 'retval', i.e. whether we should return a value
        // (will be null if no value returned)
        //
        // Second SQBool is 'raiseerror', if a runtime error occurs during the 
        // execution of the call, the vm will invoke the error handler.
        sq_call(vm.vm, parameters.count+1, SQBool(SQTrue), SQBool(SQTrue))
        let result = vm.stack[-1]
        
        vm.stack.top = top
        
        return result
    }
}
