//
//  When.swift
//  Pods
//
//  Created by Siarhei Fedartsou on 03.05.17.
//
//

import Foundation

fileprivate let workingQueue = DispatchQueue(label: "com.when.queue", attributes: .concurrent)


fileprivate final class ResultBox {
    var value: Any?
    var error: Error?
    
    func cast<T>() -> T {
        return value as! T
    }
}

fileprivate func run<T>(job: Job<T>, group: DispatchGroup, resultBox: ResultBox) {
    group.enter()
    job.run(onSuccess: { result in
        resultBox.value = result
        group.leave()
    }, onFailure: { error in
        resultBox.error = error
        group.leave()
    })
}

public func when<A, B>(_ jobA: Job<A>, _ jobB: Job<B>, timeout: DispatchTime = .now() + .seconds(15), queue: DispatchQueue = .main, onSuccess: @escaping (A, B) -> Void, onError: @escaping (Error) -> Void) {
    workingQueue.async {
        let group = DispatchGroup()
    
        let resultA = ResultBox()
        run(job: jobA, group: group, resultBox: resultA)
        
        let resultB = ResultBox()
        run(job: jobB, group: group, resultBox: resultB)
        
        group.notify(queue: queue) {
            let results = [resultA, resultB]
            if let firstError = results.first(where: { $0.error != nil })?.error {
                onError(firstError)
            } else {
                onSuccess(resultA.cast(), resultB.cast())
            }
        }
        
        if group.wait(timeout: timeout) == .timedOut {
            queue.async {
                onError(WhenError.timedOut)
            }
        }
    }
}


public func when<A, B, C>(_ jobA: Job<A>, _ jobB: Job<B>, _ jobC: Job<C>, timeout: DispatchTime = .now() + .seconds(15), queue: DispatchQueue = .main, onSuccess: @escaping (A, B, C) -> Void, onError: @escaping (Error) -> Void) {
    workingQueue.async {
        let group = DispatchGroup()
        
        let resultA = ResultBox()
        run(job: jobA, group: group, resultBox: resultA)
        
        let resultB = ResultBox()
        run(job: jobB, group: group, resultBox: resultB)
        
        let resultC = ResultBox()
        run(job: jobC, group: group, resultBox: resultC)

        group.notify(queue: queue) {
            let results = [resultA, resultB, resultC]
            if let firstError = results.first(where: { $0.error != nil })?.error {
                onError(firstError)
            } else {
                onSuccess(resultA.cast(), resultB.cast(), resultC.cast())
            }
        }
        
        if group.wait(timeout: timeout) == .timedOut {
            queue.async {
                onError(WhenError.timedOut)
            }
        }
    }
}

public func when<A, B, C, D>(_ jobA: Job<A>, _ jobB: Job<B>, _ jobC: Job<C>, _ jobD: Job<D>, timeout: DispatchTime = .now() + .seconds(15), queue: DispatchQueue = .main, onSuccess: @escaping (A, B, C, D) -> Void, onError: @escaping (Error) -> Void) {
    workingQueue.async {
        let group = DispatchGroup()
        group.enter()
        
        let resultA = ResultBox()
        run(job: jobA, group: group, resultBox: resultA)
        
        let resultB = ResultBox()
        run(job: jobB, group: group, resultBox: resultB)
        
        let resultC = ResultBox()
        run(job: jobC, group: group, resultBox: resultC)
        
        let resultD = ResultBox()
        run(job: jobD, group: group, resultBox: resultD)

        group.notify(queue: queue) {
            let results = [resultA, resultB, resultC, resultD]
            if let firstError = results.first(where: { $0.error != nil })?.error {
                onError(firstError)
            } else {
                onSuccess(resultA.cast(), resultB.cast(), resultC.cast(), resultD.cast())
            }
        }
        
        if group.wait(timeout: timeout) == .timedOut {
            queue.async {
                onError(WhenError.timedOut)
            }
        }
    }
}

public func when<A, B, C, D, E>(_ jobA: Job<A>, _ jobB: Job<B>, _ jobC: Job<C>, _ jobD: Job<D>, _ jobE: Job<E>, timeout: DispatchTime = .now() + .seconds(15), queue: DispatchQueue = .main, onSuccess: @escaping (A, B, C, D, E) -> Void, onError: @escaping (Error) -> Void) {
    workingQueue.async {
        let group = DispatchGroup()
        group.enter()
        
        let resultA = ResultBox()
        run(job: jobA, group: group, resultBox: resultA)
        
        let resultB = ResultBox()
        run(job: jobB, group: group, resultBox: resultB)
        
        let resultC = ResultBox()
        run(job: jobC, group: group, resultBox: resultC)
        
        let resultD = ResultBox()
        run(job: jobD, group: group, resultBox: resultD)
        
        let resultE = ResultBox()
        run(job: jobE, group: group, resultBox: resultE)
        
        group.notify(queue: queue) {
            let results = [resultA, resultB, resultC, resultD, resultE]
            if let firstError = results.first(where: { $0.error != nil })?.error {
                onError(firstError)
            } else {
                onSuccess(resultA.cast(), resultB.cast(), resultC.cast(), resultD.cast(), resultE.cast())
            }
        }
        
        if group.wait(timeout: timeout) == .timedOut {
            queue.async {
                onError(WhenError.timedOut)
            }
        }
    }
}
