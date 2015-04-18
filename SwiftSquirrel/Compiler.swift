//
//  Compiler.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 18.04.15.
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

public class Compiler {
    public typealias Result = SwiftSquirrel.Result<String, SQValue>
    
    init(vm: SquirrelVM) {
        self.vm = vm.vm
        self.stack = vm.stack
    }
    
    // MARK: - methods
    public func execute(#script: String) -> Result {
        var result = Result.error("Unknown error occurred")
        let (length, cScript) = script.toSquirrelString()
        
        
        let top = stack.top
        
        if (SQ_SUCCEEDED(sq_compilebuffer(vm, cScript, length, cBufferName, SQBool(SQTrue)))) {
            sq_pushroottable(vm)
            if (SQ_SUCCEEDED(sq_call(vm, 1, SQBool(SQTrue), SQBool(SQTrue)))) {
                result = Result.success(stack[-1])
            }
        }
        
        stack.top = top
        
        return result
    }
    
    // MARK: - private
    private let vm: HSQUIRRELVM
    private let stack: Stack
    
    private let (bufferNameLength, cBufferName) = "buffer".toSquirrelString()
}