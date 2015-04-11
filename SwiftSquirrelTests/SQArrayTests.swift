//
//  SQArrayTests.swift
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
import XCTest
import SwiftSquirrel

class SQArrayTests: XCTestCase {
    let squirrel: SquirrelVM = SquirrelVM.init()
    
    // MARK: - basic tests
    func testThat_defaultInitialSizeIsZero() {
        let array = SQArray(vm: squirrel)
        XCTAssertEqual(array.count, 0, "SQArray default initial size should be zero")
    }
    
    func testThat_initialSizeIsSet() {
        let array = SQArray(vm: squirrel, size: 10)
        XCTAssertEqual(array.count, 10, "SQArray should be created with the provided size")
    }
    
    func testThat_initialValuesAreNull() {
        let array = SQArray(vm: squirrel, size: 10)
        XCTAssertEqual(array[0], .Null, "SQArray should be filled with null values initially")
    }
    
    // MARK: getter/setter tests
    func testThat_intValuesCanBeSet() {
        let array = SQArray(vm: squirrel, size: 10)
        array[1] = 2
        XCTAssertEqual(array[1], 2, "SQArray should be able to contain Int values")
    }
    
    func testThat_floatValuesCanBeSet() {
        let array = SQArray(vm: squirrel, size: 10)
        array[1] = 0.5
        XCTAssertEqual(array[1], 0.5, "SQArray should be able to contain Float values")
    }
    
    func testThat_stringValuesCanBeSet() {
        let array = SQArray(vm: squirrel, size: 10)
        array[1] = "text"
        XCTAssertEqual(array[1], "text", "SQArray should be able to contain String values")
    }
    
    func testThat_boolValuesCanBeSet() {
        let array = SQArray(vm: squirrel, size: 10)
        array[1] = true
        XCTAssertEqual(array[1], true, "SQArray should be able to contain Bool values")
    }
    
    func testThat_tableValuesCanBeSet() {
        let array = SQArray(vm: squirrel, size: 10)
        array[1] = squirrel.rootTable.asSQValue
        XCTAssertEqual(array[1], squirrel.rootTable.asSQValue, "SQArray should be able to contain SQTable values")
    }
}