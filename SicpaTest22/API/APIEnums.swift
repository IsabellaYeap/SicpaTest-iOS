//
//  APIEnums.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

protocol EnvironmentProtocol {
    var headers: RequestHeaders? { get }
    var baseURL: String { get }
}

public enum Result<T> {
    case success(T)
    case failure(CustomError)
}

public enum CustomError {
    case Unknown
    case APIKeyInvalid
    case ServerError(_ error: Error)
    case DecodingError
    case InvalidResponse
    case BadRequest(_ error: Error)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("Oops! Something went wrong! (\(self))", comment: "Custom Error")
    }
}

public enum RuntimeError: Error {
    case customError(_ message: String)
}

extension RuntimeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError(let message):
            return NSLocalizedString(message, comment: "Runtime error")
        }
    }
}

public enum APIEnvironment: EnvironmentProtocol {
    case Nytimes
    
    var headers: RequestHeaders? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    var baseURL: String {
        switch self {
        case .Nytimes:
            return "https://api.nytimes.com/svc/"
        }
    }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum RequestType {
    case data
}

public enum ResponseType {
    case data
}

public enum OperationResult {
    case data(_ : Data?, _ : HTTPURLResponse?)
    case error(_ : CustomError, _ : HTTPURLResponse?)
}
