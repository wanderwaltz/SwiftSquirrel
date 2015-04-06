//
//  KeyValueGenerator.swift
//  SwiftSquirrel
//
//  Created by Egor Chiglintsev on 07.04.15.
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

// MARK: - SquirrelCollection
public protocol SquirrelCollection {
}


// MARK: - KeyValueGenerator
public class KeyValueGenerator<T: SQObject where T: SquirrelCollection>: GeneratorType {
    // MARK: - KeyValueGenerator::initializers
    init(vm: SquirrelVM, collection: T) {
        self.vm = vm
        
        vm.stack << collection
        vm.stack << .Null
    }
    
    // MARK: - KeyValueGenerator::<GeneratorType>
    public func next() -> (SQValue, SQValue)? {
        if SQ_SUCCEEDED(sq_next(vm.vm, -2)) {
            let result = (vm.stack[-2], vm.stack[-1])
            // pop the key/value pair
            vm.stack.pop(2)
            return result
        }
        else {
            // pop the iterator
            vm.stack.pop(1)
            return nil
        }
    }
    
    // MARK: - KeyValueGenerator::private
    private let vm: SquirrelVM
}