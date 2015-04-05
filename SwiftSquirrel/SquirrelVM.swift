//
//  SquirrelVM.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 05.04.15.
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

public class SquirrelVM {
    // MARK: - SquirrelVM::constants
    public static let DefaultStackSize = 1024
    
    // MARK: - SquirrelVM::properties
    public let stack: VMStack
    
    // MARK: - SquirrelVM::initializers
    public init(stackSize: Int) {
        vm = sq_open(SQInteger(stackSize))
        stack = Stack(vm: vm)
    }
    
    convenience public init() {
        self.init(stackSize: SquirrelVM.DefaultStackSize)
    }
    
    deinit {
        sq_close(vm)
    }
    
    // MARK: - SquirrelVM::private
    private let vm: HSQUIRRELVM
    
    // MARK: - SquirrleVM::private: stack
    private class Stack: VMStack {
        // MARK: - SquirrelVM::Stack::<VMStack>
        private var top: Int {
            get {
                return Int(sq_gettop(vm))
            }
            
            set(value) {
                sq_settop(vm, SQInteger(value))
            }
        }
        
        private func push(x: Int) {
            sq_pushinteger(vm, SQInteger(x))
        }
        
        private func push(x: Float) {
            sq_pushfloat(vm, SQFloat(x))
        }
        
        
        private subscript(position: Int) -> SQValue {
            switch (sq_gettype(vm, SQInteger(position)).value) {
                
            case OT_INTEGER.value:
                var value: SQInteger = 0
                sq_getinteger(vm, SQInteger(position), &value)
                return SQValue.Int(Int(value))
                
            case OT_FLOAT.value:
                var value: SQFloat = 0
                sq_getfloat(vm, SQInteger(position), &value)
                return SQValue.Float(Float(value))
                
            default:
                return SQValue.Null
            }
        }
        
        
        private func integer(at position: Int) -> Int? {
            var result: Int? = nil
            
            switch (self[position]) {
                
            case let .Int(value):
                result = value
                
            case let .Float(value):
                result = Int(value)
                
            default:
                result = nil
            }
            
            return result
        }
        
        private func float(at position: Int) -> Float? {
            var result: Float? = nil
            
            switch (self[position]) {
                
            case let .Int(value):
                result = Float(value)
                
            case let .Float(value):
                result = value
                
            default:
                result = nil
            }
            
            return result
        }
        

        // MARK: - SquirrelVM::Stack::initializers
        private init(vm: HSQUIRRELVM) {
            self.vm = vm
        }
        
        // MARK: - SquirrelVM::Stack::private
        private let vm: HSQUIRRELVM
    }
}
