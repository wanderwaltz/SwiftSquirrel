//
//  SQTableTests.swift
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
import XCTest
import SwiftSquirrel

class SQTableTests: XCTestCase {
    let squirrel: SquirrelVM = SquirrelVM.init()
    
    // MARK: - basic setter/getter tests
    func testThat_tableCanSetIntegerForStringKey() {
        let table = squirrel.rootTable
        table["key"] = 123
        XCTAssertEqual(table["key"], 123,
            "SQTable should be able to set Int value for String key")
    }
    
    
    func testThat_tableCanResetValue() {
        let table = squirrel.rootTable
        table["key"] = 123
        table["key"] = 456
        XCTAssertEqual(table["key"], 456,
            "SQTable should be able to set the value again after setting it for the first time")
    }
    
    
    func testThat_defaultValueIsNull() {
        let table = squirrel.rootTable
        XCTAssertEqual(table["key"], SQValue.Null,
            "SQTable should return .Null for undefined keys")
    }
    
    
    func testThat_tableCanSetStringForIntegerKey() {
        let table = squirrel.rootTable
        table[123] = "value"
        XCTAssertEqual(table[123], "value",
            "SQTable should be able to set String value for Int key")
    }
    
    
    // MARK: - count tests
    func testThat_isInitiallyEmpty() {
        let table = SQTable(vm: squirrel)
        XCTAssertEqual(table.count, 0, "SQTable should be initially empty")
    }
    
    
    func testThat_setterIncreasesCount() {
        let table = SQTable(vm: squirrel)
        table[123] = 456
        XCTAssertEqual(table.count, 1, "Setting a value should increase count of the SQTable")
    }
    
    
    func testThat_settingForSameKeyDoesNotIncreaseCountFuther() {
        let table = SQTable(vm: squirrel)
        table[123] = 456
        table[123] = 789
        XCTAssertEqual(table.count, 1, "Setting a value twice for the same key should not further increase count")
    }
    
    
    func testThat_settingMultipleValuesYieldCorrespondingCount() {
        let table = SQTable(vm: squirrel)
        for i in 0...10 {
            table[i] = (i+1).asSQValue
            XCTAssertEqual(table.count, i+1, "Setting multiple values should yield corresponding count each time")
        }
    }
}