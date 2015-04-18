//
//  SQClosureTests.swift
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
import XCTest
import SwiftSquirrel

class SQClosureTests: XCTestCase {
    let squirrel: SquirrelVM = SquirrelVM.init()
    
    func testThat_closureIsCallableAndReturnsIntValue() {
        let result = squirrel.compiler.execute(script: "return function(a, b) { return a+b; }").success!.asClosure!
        XCTAssertEqual(result.call(5,3), 8, "SQClosure should be callable and properly return int values")
    }
    
    func testThat_closureIsCallableAndReturnsFloatValue() {
        let result = squirrel.compiler.execute(script: "return function(a, b) { return a/b; }").success!.asClosure!
        XCTAssertEqual(result.call(1.0,4.0), 0.25, "SQClosure should be callable and properly return float values")
    }
    
    func testThat_closureIsCallableAndReturnsStringValue() {
        let result = squirrel.compiler.execute(script: "return function(a, b) { return a+b; }").success!.asClosure!
        XCTAssertEqual(result.call("a","b"), "ab", "SQClosure should be callable and properly return string values")
    }
    
    func testThat_closureIsCallableAndReturnsBoolValue() {
        let result = squirrel.compiler.execute(script: "return function(a) { return !a; }").success!.asClosure!
        XCTAssertEqual(result.call(false), true, "SQClosure should be callable and properly return bool values")
    }
    
    func testThat_defaultThisIsRootTable() {
        let result = squirrel.compiler.execute(script: "a <- 123; return function(b) { return this.a+b; }").success!.asClosure!
        XCTAssertEqual(result.call(1), 124, "Default `this` should be set to root table")
    }
    
    func testThat_thisIsRedirectedProperly() {
        let result = squirrel.compiler.execute(script:
            "a <- 123; env <- { a = 456 }; " +
            "return function(b) { return this.a+b; }").success!.asClosure!
        
        let env = squirrel.rootTable["env"].asObject!
        
        XCTAssertEqual(result.call(this: env, parameters: 1), 457,
            "`this` should be redirected properly")
    }
}
