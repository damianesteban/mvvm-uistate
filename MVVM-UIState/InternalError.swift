//
//  InternalError.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

struct InternalError: Swift.Error {
    public let file: StaticString
    public let function: StaticString
    public let line: UInt
    public let message: String
    public let underlyingError: Swift.Error?

    public init(message: String, file: StaticString = #file, function: StaticString = #function,
                line: UInt = #line, underlyingError: Swift.Error? = nil) {
        self.file = file
        self.function = function
        self.line = line
        self.message = message
        self.underlyingError = underlyingError
    }
}
