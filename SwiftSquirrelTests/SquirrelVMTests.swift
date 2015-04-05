//
//  SwiftSquirrelTests.swift
//  SwiftSquirrelTests
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

import UIKit
import XCTest
import SwiftSquirrel

class SquirrelVMTests: XCTestCase {
    var squirrel: SquirrelVM = SquirrelVM.init()
    
    // MARK: - basic stack tests
    func testThat_initialStackTopIsZero() {
        XCTAssertEqual(squirrel.stack.top, 0,
            "Initial Squirrel VM stack top should be zero")
    }
    
    
    func testThat_pushingIncreasesStackTop() {
        squirrel.stack <- 10
        XCTAssertEqual(squirrel.stack.top, 1,
            "Pushing a value to the Squirrel VM stack should increase its top by 1")
    }
    
    
    func testThat_decreasingStackTopManuallyIsAllowed() {
        squirrel.stack <- 10
        squirrel.stack.top = 0
        XCTAssertEqual(squirrel.stack.top, 0,
            "Stack top can be set manually to pop any number of elements from the stack")
    }
    
        
    // MARK: - stack integers
    func testThat_canReadPushedIntegerByForwardIndex() {
        squirrel.stack <- 1
        squirrel.stack <- 2
        XCTAssertEqual(squirrel.stack.integer(at: 1)!, 1,
            "Should be able to read integer values by passing forward (positive) indexes")
    }
    
    
    func testThat_canReadPushedIntegerByReverseIndex() {
        squirrel.stack <- 1
        squirrel.stack <- 2
        XCTAssertEqual(squirrel.stack.integer(at: -1)!, 2,
            "Should be able to read integer values by passing reverse (negative) indexes")
    }
    
    
    // MARK: - stack floats
    func testThat_canReadPushedFloatByForwardIndex() {
        squirrel.stack <- 1.0
        squirrel.stack <- 2.0
        XCTAssertEqual(squirrel.stack.float(at: 1)!, 1.0,
            "Should be able to read float values by passing forward (positive) indexes")
    }
    
    
    func testThat_canReadPushedFloatByReverseIndex() {
        squirrel.stack <- 1.0
        squirrel.stack <- 2.0
        XCTAssertEqual(squirrel.stack.float(at: -1)!, 2.0,
            "Should be able to read float values by passing reverse (negative) indexes")
    }
    
    // MARK: - stack integer to float conversion
    func testThat_integersAreConvertibleToFloats() {
        squirrel.stack <- 1
        XCTAssertEqual(squirrel.stack.float(at: 1)!, 1.0,
            "Stack should be able to convert integer values to floats")
    }
    
    
    func testThat_floatsAreConvertibleToIntegers() {
        squirrel.stack <- 1.0
        XCTAssertEqual(squirrel.stack.integer(at: 1)!, 1,
            "Stack should be able to convert float values to integers")
    }
}
