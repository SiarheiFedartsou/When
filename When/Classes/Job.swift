//
//  Job.swift
//  Pods
//
//  Created by Siarhei Fedartsou on 03.05.17.
//
//

import Foundation


public struct Job<T> {
    private let runner: (_ onSuccess: @escaping (T) -> Void, _ onFailure: @escaping (Error) -> Void) -> Void
    public init(runner: @escaping (_ onSuccess: @escaping (T) -> Void, _ onFailure: @escaping (Error) -> Void) -> Void) {
        self.runner = runner
    }
    
    func run(onSuccess: @escaping (T) -> Void, onFailure: @escaping (Error) -> Void) {
        runner(onSuccess, onFailure)
    }
}
