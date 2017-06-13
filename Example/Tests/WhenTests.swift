//
//  WhenTests.swift
//  When
//
//  Created by Siarhei Fedartsou on 03.05.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import JustWhen
import XCTest
import Result

class WhenTests: XCTestCase {
    
    enum FakeError: Error {
        case fakeError
    }
    

    private func successfulJob<T>(_ result: T) -> Job<T> {
        return Job { onSuccess, onFailure in
            let deadlineTime = DispatchTime.now() + .nanoseconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                onSuccess(result)
            }
        }
    }
    
    private func failedJob() -> Job<Int> {
        return Job { onSuccess, onFailure in
            let deadlineTime = DispatchTime.now() + .nanoseconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                onFailure(FakeError.fakeError)
            }
        }
    }
    
    
    
    func testWhenReturnsAllResultsIfAllJobsWereSuccessful() {
        // when
        var resultA: Int?
        var resultB: String?
        var error: Error? = nil
        
        when(successfulJob(42), successfulJob("foo"), onSuccess: { a, b in
            resultA = a
            resultB = b
        }, onError: { e in
            error = e
        })
        
        // then
        expect(resultA).toEventually(equal(42))
        expect(resultB).toEventually(equal("foo"))
        expect(error).toEventually(beNil())
    }
    
    func testWhenReturnsErrorResultsIfAtLeastOneJobFailed() {
        // when
        var resultA: Int?
        var resultB: Int?
        var error: Error? = nil
        
        when(successfulJob(42), failedJob(), onSuccess: { a, b in
            resultA = a
            resultB = b
        }, onError: { e in
            error = e
        })
        
        // then
        expect(resultA).toEventually(beNil())
        expect(resultB).toEventually(beNil())
        expect(error).toEventuallyNot(beNil())
    }
}

