//
//  WrapTests.swift
//  When
//
//  Created by Siarhei Fedartsou on 03.05.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import Result
import JustWhen

class WrapTests: XCTestCase {
    
    enum FakeError: Error {
        case fakeError
    }
    

    
    func testWrapWrapsAsyncFunctionsWithoutArguments() {
        // given
        func successfulAsyncTask(completionHandler: @escaping (Result<Int, FakeError>) -> Void) {
            let deadlineTime = DispatchTime.now() + .nanoseconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                completionHandler(Result(42))
            }
        }
        
        // when
        var resultA: Int?
        var resultB: Int?
        var error: Error? = nil
        
        when(wrap(successfulAsyncTask), wrap(successfulAsyncTask), onSuccess: { a, b in
            resultA = a
            resultB = b
        }, onError: { e in
            error = e
        })
        
        // then
        expect(resultA).toEventually(equal(42))
        expect(resultB).toEventually(equal(42))
        expect(error).toEventually(beNil())
    }
    
    func testWrapWrapsAsyncFunctionsWithOneArgument() {
        // given
        func successfulAsyncTask(arg: Int, completionHandler: @escaping (Result<Int, FakeError>) -> Void) {
            let deadlineTime = DispatchTime.now() + .nanoseconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                completionHandler(Result(arg))
            }
        }
        
        // when
        var resultA: Int?
        var resultB: Int?
        var error: Error? = nil
        
        when(wrap(successfulAsyncTask)(42), wrap(successfulAsyncTask)(41), onSuccess: { a, b in
            resultA = a
            resultB = b
        }, onError: { e in
            error = e
        })
        
        // then
        expect(resultA).toEventually(equal(42))
        expect(resultB).toEventually(equal(41))
        expect(error).toEventually(beNil())
    }
    
    func testWrapWrapsAsyncFunctionsWithTwoArgument() {
        // given
        func successfulAsyncTask(argA: Int, argB: String, completionHandler: @escaping (Result<[String], FakeError>) -> Void) {
            let deadlineTime = DispatchTime.now() + .nanoseconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                completionHandler(Result(Array(repeating: argB, count: argA)))
            }
        }
        
        // when
        var resultA: [String]?
        var resultB: [String]?
        var error: Error? = nil
        
        when(wrap(successfulAsyncTask)(3, "foo"), wrap(successfulAsyncTask)(3, "bar"), onSuccess: { a, b in
            resultA = a
            resultB = b
        }, onError: { e in
            error = e
        })
        
        // then
        expect(resultA).toEventually(equal(["foo", "foo", "foo"]))
        expect(resultB).toEventually(equal(["bar", "bar", "bar"]))
        expect(error).toEventually(beNil())
    }
    
    
}
