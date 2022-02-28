//
//  APIOperation.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

protocol OperationProtocol {
    associatedtype Output
    
    var request: RequestProtocol { get }
    func execute(in requestDispatcher: RequestDispatcherProtocol, completion: @escaping (Output) -> Void) -> Void
    func cancel() -> Void
}

class APIOperation: OperationProtocol {
    typealias Output = OperationResult
    
    private var task: URLSessionDataTask?
    
    internal var request: RequestProtocol
    
    init(_ request: RequestProtocol) {
        self.request = request
    }
    
    func cancel() {
        task?.cancel()
    }
    
    /// Execute the  protocol-oriented of each operation of 'requests' to standard result
    ///
    /// Use this method send request to the rest api
    ///
    ///     let dispatcher = APIRequestDispatcher()
    ///     let operation = APIOperation()
    ///     operation.execute(in: dispatcher) { (result) in
    ///         print(result)
    ///     }
    ///
    /// [...]
    ///
    /// - Parameter dispatcher: The session to request to the operation
    ///
    /// - Returns: An operation result containing data format, file url or error
    ///
    ///
    func execute(in requestDispatcher: RequestDispatcherProtocol, completion: @escaping (OperationResult) -> Void) {
        task = requestDispatcher.execute(request: request, completion: { (result) in
            completion(result)
        })
    }
}
