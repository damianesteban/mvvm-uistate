//
//  Result.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case .success(let t): return .success(f(t))
        case .failure(let error): return .failure(error)
        }
    }

    func flatMap<U>(f: (T) -> Result<U>) -> Result<U> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let error): return .failure(error)
        }
    }
}

extension Result {
    // Return the value if it is a .success or throw the error if it is a .failure
    func resolve() throws -> T {
        switch self {
        case Result.success(let value): return value
        case Result.failure(let error): throw error
        }
    }

    // Construct a .Success if the expression returns a value or a .Failure if it throws
    init( _ throwingExpression: (Void) throws -> T) {
        do {
            let value = try throwingExpression()
            self = Result.success(value)
        } catch {
            self = Result.failure(error)
        }
    }
}
