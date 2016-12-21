//
//  Person.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

struct Person {
    let name: String
    let age: String
}

extension Person: JSONDeserializable {
    init(jsonRepresentation: JSONDictionary) throws {
        name = try decode(jsonRepresentation, key: "name")
        age = try decode(jsonRepresentation, key: "age")
    }
}
