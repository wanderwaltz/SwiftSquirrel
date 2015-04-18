//
//  CompilerTests.swift
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
import XCTest
import SwiftSquirrel

class CompilerTests: XCTestCase {
    let squirrel: SquirrelVM = SquirrelVM.init()
    
    func testThat_compilerReturnsIntValue() {
        let result = squirrel.compiler.execute(script: "return 123")
        XCTAssertEqual(result.success!.asInt!, 123,
            "Compiler should return the integer return value of the script as SQValue.Int")
    }
    
    
    func testThat_compilerReturnsFloatValue() {
        let result = squirrel.compiler.execute(script: "return 1.25")
        XCTAssertEqual(result.success!.asFloat!, 1.25,
            "Compiler should return the float return value of the script as SQValue.Float")
    }
    
    
    func testThat_compilerReturnsBoolValue() {
        let result = squirrel.compiler.execute(script: "return true")
        XCTAssertEqual(result.success!.asBool!, true,
            "Compiler should return the boolean return value of the script as SQValue.Bool")
    }
    
    
    func testThat_compilerReturnsStringValue() {
        let result = squirrel.compiler.execute(script: "return \"text\"")
        XCTAssertEqual(result.success!.asString!, "text",
            "Compiler should return the string return value of the script as SQValue.String")
    }
    
    
    func testThat_compilerReturnsTableValue() {
        let result = squirrel.compiler.execute(script: "return { x = 123, y = true, z = 1.25 }")
        let expected: [SQValue: SQValue] = ["x" : 123, "y" : true, "z": 1.25]
        XCTAssertTrue(result.success!.asTable! == expected,
            "Compiler should return the table return value of the script as SQValue.Object")
    }
    
    
    func testThat_compilerReturnsArrayValue() {
        let result = squirrel.compiler.execute(script: "return [123, true, 1.25]")
        let expected: [SQValue] = [123, true, 1.25]
        XCTAssertTrue(result.success!.asArray! == expected,
            "Compiler should return the array return value of the script as SQValue.Object")
    }
    
    
    func testThat_compilerReturnsNullValue() {
        let result = squirrel.compiler.execute(script: "return null")
        XCTAssertEqual(result.success!, .Null,
            "Compiler should return the null return value of the script as SQValue.Null")
    }
    
    
    func testThat_voidReturnEqualsNull() {
        let result = squirrel.compiler.execute(script: "return")
        XCTAssertEqual(result.success!, .Null, "void return values should be treated as .Null")
    }
    
    
    func testThat_compilerWorksWithRootTable() {
        squirrel.compiler.execute(script: "intVar <- 123; stringVar <- \"test\";")
        XCTAssertEqual(squirrel.rootTable["intVar"], 123, "")
        XCTAssertEqual(squirrel.rootTable["stringVar"], "test", "")
    }
    
    
    func testThat_invalidScriptReturnsError() {
        let result = squirrel.compiler.execute(script: "&*^$!@")
        XCTAssertTrue(result.error != nil, "Compiler should return error for invalid scripts")
    }
}
