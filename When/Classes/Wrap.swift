//
//  Wrap.swift
//  Pods
//
//  Created by Siarhei Fedartsou on 03.05.17.
//
//

import Foundation
import Result

public func wrap<T, ErrorType: Error>(_ function: @escaping (@escaping (Result<T, ErrorType>) -> Void) -> Void) -> Job<T> {
    return Job { onSuccess, onFailure in
        function { result in
            switch result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}

public func wrap<A, T, ErrorType: Error>(_ function: @escaping (A, @escaping (Result<T, ErrorType>) -> Void) -> Void) -> ((A) -> Job<T>) {
    return { a in
        return Job { onSuccess, onFailure in
            function(a) { result in
                switch result {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onFailure(error)
                }
            }
        }
    }
}

public func wrap<A, B, T, ErrorType: Error>(_ function: @escaping (A, B, @escaping (Result<T, ErrorType>) -> Void) -> Void) -> ((A, B) -> Job<T>) {
    return { a, b in
        return Job { onSuccess, onFailure in
            function(a, b) { result in
                switch result {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onFailure(error)
                }
            }
        }
    }
}

public func wrap<A, B, C, T, ErrorType: Error>(_ function: @escaping (A, B, C, @escaping (Result<T, ErrorType>) -> Void) -> Void) -> ((A, B, C) -> Job<T>) {
    return { a, b, c in
        return Job { onSuccess, onFailure in
            function(a, b, c) { result in
                switch result {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onFailure(error)
                }
            }
        }
    }
}

public func wrap<A, B, C, D, T, ErrorType: Error>(_ function: @escaping (A, B, C, D, @escaping (Result<T, ErrorType>) -> Void) -> Void) -> ((A, B, C, D) -> Job<T>) {
    return { a, b, c, d in
        return Job { onSuccess, onFailure in
            function(a, b, c, d) { result in
                switch result {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onFailure(error)
                }
            }
        }
    }
}

public func wrap<A, B, C, D, E, T, ErrorType: Error>(_ function: @escaping (A, B, C, D, E, @escaping (Result<T, ErrorType>) -> Void) -> Void) -> ((A, B, C, D, E) -> Job<T>) {
    return { a, b, c, d, e in
        return Job { onSuccess, onFailure in
            function(a, b, c, d, e) { result in
                switch result {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onFailure(error)
                }
            }
        }
    }
}
