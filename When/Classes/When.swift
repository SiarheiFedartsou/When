//
//  When.swift
//  Pods
//
//  Created by Siarhei Fedartsou on 03.05.17.
//
//

import Foundation

fileprivate let queue = DispatchQueue(label: "com.when.queue", attributes: .concurrent)


public func when<A, B>(_ jobA: Job<A>, _ jobB: Job<B>, timeout: DispatchTime = .now() + .seconds(15), queue: DispatchQueue = .main, onSuccess: @escaping (A, B) -> Void, onError: @escaping (Error) -> Void) {
    queue.async {
        let group = DispatchGroup()
        group.enter()
        
        var resultA: A? = nil
        var resultB: B? = nil
        
        var lastError: Error? = nil
        
        jobA.run(onSuccess: { result in
            resultA = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobB.run(onSuccess: { result in
            resultB = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.notify(queue: queue) {
            if let lastError = lastError {
                onError(lastError)
            } else if let resultA = resultA, let resultB = resultB {
                onSuccess(resultA, resultB)
            } else {
                onError(WhenError.unknown)
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
    queue.async {
        let group = DispatchGroup()
        group.enter()
        
        var resultA: A? = nil
        var resultB: B? = nil
        var resultC: C? = nil
        
        var lastError: Error? = nil
        
        jobA.run(onSuccess: { result in
            resultA = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobB.run(onSuccess: { result in
            resultB = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobC.run(onSuccess: { result in
            resultC = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        
        group.notify(queue: queue) {
            if let lastError = lastError {
                onError(lastError)
            } else if let resultA = resultA, let resultB = resultB, let resultC = resultC {
                onSuccess(resultA, resultB, resultC)
            } else {
                onError(WhenError.unknown)
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
    queue.async {
        let group = DispatchGroup()
        group.enter()
        
        var resultA: A? = nil
        var resultB: B? = nil
        var resultC: C? = nil
        var resultD: D? = nil
        
        var lastError: Error? = nil
        
        jobA.run(onSuccess: { result in
            resultA = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobB.run(onSuccess: { result in
            resultB = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobC.run(onSuccess: { result in
            resultC = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobD.run(onSuccess: { result in
            resultD = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.notify(queue: queue) {
            if let lastError = lastError {
                onError(lastError)
            } else if let resultA = resultA, let resultB = resultB, let resultC = resultC, let resultD = resultD {
                onSuccess(resultA, resultB, resultC, resultD)
            } else {
                onError(WhenError.unknown)
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
    queue.async {
        let group = DispatchGroup()
        group.enter()
        
        var resultA: A? = nil
        var resultB: B? = nil
        var resultC: C? = nil
        var resultD: D? = nil
        var resultE: E? = nil
        
        var lastError: Error? = nil
        
        jobA.run(onSuccess: { result in
            resultA = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobB.run(onSuccess: { result in
            resultB = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobC.run(onSuccess: { result in
            resultC = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobD.run(onSuccess: { result in
            resultD = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.enter()
        jobE.run(onSuccess: { result in
            resultE = result
            group.leave()
        }, onFailure: { error in
            lastError = error
            group.leave()
        })
        
        group.notify(queue: queue) {
            if let lastError = lastError {
                onError(lastError)
            } else if let resultA = resultA, let resultB = resultB, let resultC = resultC, let resultD = resultD, let resultE = resultE {
                onSuccess(resultA, resultB, resultC, resultD, resultE)
            } else {
                onError(WhenError.unknown)
            }
        }
        
        if group.wait(timeout: timeout) == .timedOut {
            queue.async {
                onError(WhenError.timedOut)
            }
        }
    }
}
