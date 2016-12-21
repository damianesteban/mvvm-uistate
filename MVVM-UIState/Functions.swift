//
//  Functions.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

func jsonObject(from data: Data) -> Result<Any> {
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        return .success(jsonObject)
    } catch let error {
        return .failure(InternalError(message: "Error parsing JSON", underlyingError: error))
    }
}

func parseObjectToDictionary(object: Any) -> Result<JSONDictionary> {
    guard let dictionary = object as? JSONDictionary else {
        return Result.failure(InternalError(message: "Unable to parse object to dictionary"))
    }
    print("DICTIONARY: \(dictionary)")
    return Result.success(dictionary)
}

func parseJSONArray(from dictionary: JSONDictionary) -> Result<JSONArray> {
    guard let array = dictionary["results"] as? JSONArray else {
        return .failure(InternalError(message: "Unable to parse dictionary to json array"))
    }
    print("ARRAY: \(array)")
    return .success(array)
}
