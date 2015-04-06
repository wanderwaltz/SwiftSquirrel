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
    internal let vm: HSQUIRRELVM
    
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
        
        private func push(x: SQValue) {
            switch (x) {
            case let .Int(value):
                sq_pushinteger(vm, SQInteger(value))
                
            case let .Float(value):
                sq_pushfloat(vm, SQFloat(value))
                
            case let .Bool(value):
                sq_pushbool(vm, (value == true) ? SQBool(SQTrue) : SQBool(SQFalse))
                
            case let .String(value):
                let cString = (value as NSString).UTF8String
                let length = strlen(cString)
                sq_pushstring(vm, cString, SQInteger(length))
                
            case .Null:
                sq_pushnull(vm)
            }
        }
        
        private func push(x: Int) {
            push(SQValue.Int(x))
        }
        
        private func push(x: Float) {
            push(SQValue.Float(x))
        }
        
        private func push(x: Bool) {
            push(SQValue.Bool(x))
        }
        
        private func push(x: String) {
            push(SQValue.String(x))
        }
        
        
        private subscript(position: Int) -> SQValue {
            switch (sq_gettype(vm, SQInteger(position)).value) {
                
            case OT_INTEGER.value:
                var value: SQInteger = 0
                sq_getinteger(vm, SQInteger(position), &value)
                return .Int(Int(value))
                
            case OT_FLOAT.value:
                var value: SQFloat = 0
                sq_getfloat(vm, SQInteger(position), &value)
                return .Float(Float(value))
                
            case OT_BOOL.value:
                var value: SQBool = 0
                sq_getbool(vm, SQInteger(position), &value)
                return (value == SQBool(SQTrue)) ? .Bool(true) : .Bool(false)
                
            case OT_STRING.value:
                var cString: UnsafePointer<SQChar> = nil
                sq_getstring(vm, SQInteger(position), &cString)
                if let string = String.fromCString(cString) {
                    return .String(string)
                }
                else {
                    return .Null
                }
                
            default:
                return .Null
            }
        }
        
        
        private func integer(at position: Int) -> Int? {
            return self[position].asInt
        }
        
        private func float(at position: Int) -> Float? {
            return self[position].asFloat
        }
        
        private func bool(at position: Int) -> Bool? {
            return self[position].asBool
        }
        
        private func string(at position: Int) -> String? {
            return self[position].asString
        }
        

        // MARK: - SquirrelVM::Stack::initializers
        private init(vm: HSQUIRRELVM) {
            self.vm = vm
        }
        
        // MARK: - SquirrelVM::Stack::private
        private let vm: HSQUIRRELVM
    }
}
