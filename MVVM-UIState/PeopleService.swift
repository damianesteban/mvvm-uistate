//
//  PeopleService.swift
//  MVVM-UIState
//
//  Created by Damian Esteban on 12/20/16.
//  Copyright © 2016 Damian Esteban. All rights reserved.
//

import Foundation

// Resource Error
enum ResourceError: Error {
    case invalidBaseURL
}

// Errors for NetworkService
enum NetworkServiceError: Error {
    case decodeJSONError
    case statusError(status: Int)
    case otherError(Error)
}

// enum for HTTPMethod
enum Method: String {
    case GET = "GET"
}

/// A Resource - contains the bar minimum needed for a request.
protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

/// Resource Extension - provides default implementation of `method` and helper method to create URLRequest
extension Resource {

    var method: Method {
        return .GET
    }

    // Creates a URLRequest from the method, parameters and path.
    func requestWithBaseURL(baseURL: URL) -> URLRequest {
        let URL = baseURL.appendingPathComponent(path)

        // NSURLComponents can fail due to programming errors, so
        // prefer crashing than returning an optional

        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue

        return request
    }
}

// Our API represented as an enum.
enum Swapi {
    case people
}

// Conforms to Resource.
extension Swapi: Resource {

    // Sets the parameters
    var parameters: [String : String] {
        switch self {
        case .people:
        return ["":""]
        }
    }

    // Sets the path
    var path: String {
        switch self {
        case .people:
        return "/people"
        }
    }
}

class NetworkService {

    private let baseURL = URL(string: "https://www.swapi.com")!
    private let session: URLSession

    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }

    // Returns an Observable of type Data via URLSession
    func fetchData(for resource: Resource, completion: @escaping (Result<Data>) -> Void) {
        let request = resource.requestWithBaseURL(baseURL: baseURL)
        let task = self.session.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(Result.failure(NetworkServiceError.otherError(error)))

            } else {
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    fatalError("Couldn't get HTTP response")
                }

                if 200 ..< 300 ~= HTTPResponse.statusCode {
                    completion(Result.success(data ?? Data()))
                }
                else {
                    completion(Result.failure(NetworkServiceError.statusError(status: HTTPResponse.statusCode)))
                }
            }
        }
        task.resume()
    }
}
