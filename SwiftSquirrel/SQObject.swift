//
//  SQObject.swift
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

public class SQObject: Equatable {
    // MARK: - initializers
    public init(vm: SquirrelVM) {
        self.vm = vm
        self.obj = vm.object.null()
    }
    
    public init(vm: SquirrelVM, object obj: HSQOBJECT) {
        self.vm = vm
        self.obj = obj
    }
    
    convenience public init(vm: SquirrelVM, object obj: SQObject) {
        self.init(vm: vm, object: obj.obj)
    }
    
    deinit {
        vm.object.release(&_obj)
    }
    
    // MARK: - internal
    internal let vm: SquirrelVM
    internal var _obj: HSQOBJECT = HSQOBJECT()
    
    internal var obj: HSQOBJECT {
        get {
            return _obj
        }
        
        set {
            vm.object.release(&_obj)
            _obj = newValue
            vm.object.retain(&_obj)
        }
    }
}


public func == (left: SQObject, right: SQObject) -> Bool {
    return (left.vm === right.vm) && (left.vm.object.equal(left._obj, right._obj))
}