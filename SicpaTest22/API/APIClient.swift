//
//  APIClient.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

protocol RequestDispatcherProtocol {
    init(environment: EnvironmentProtocol, networkSession: NetworkSessionProtocol)
    func execute(request: RequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionDataTask?
}

class APIRequestDispatcher: RequestDispatcherProtocol {
    private var environment: EnvironmentProtocol
    private var networkSession: NetworkSessionProtocol
    
    required init(environment: EnvironmentProtocol, networkSession: NetworkSessionProtocol) {
        self.environment = environment
        self.networkSession = networkSession
    }
    
    func execute(request: RequestProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionDataTask? {
        guard var urlRequest = request.urlRequest(with: environment) else {
            completion(.error(CustomError.BadRequest(RuntimeError.customError("Device detected invalid URL for: \(request)")), nil))
            return nil
        }
        
        environment.headers?.forEach({ (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        var task: URLSessionDataTask?
        
        switch request.requestType {
        case .data:
            task = networkSession.dataTask(with: urlRequest) { (data, response, error) in
                self.handleJsonTaskResponse(data: data, urlResponse: response, error: error, completion: completion)
            }
            break
        }
        
        task?.resume()
        
        return task
    }
    
    private func handleJsonTaskResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (OperationResult) -> Void) {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(OperationResult.error(CustomError.InvalidResponse, nil))
            return
        }
        
        if let error = error {
            DispatchQueue.main.async {
                completion(OperationResult.error(.BadRequest(error), urlResponse))
            }
            return
        }
        
        let result = verify(data: data, urlResponse: urlResponse)
        switch result {
        case .success(let data):
            let parseResult = parse(data: data as? Data)
            switch parseResult {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(OperationResult.data(data, urlResponse))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(OperationResult.error(error, urlResponse))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(OperationResult.error(error, urlResponse))
            }
        }
    }
    
    private func parse(data: Data?) -> Result<Data> {
        guard let data = data else {
            return .failure(CustomError.InvalidResponse)
        }
        return .success(data)
    }
    
    private func verify(data: Any?, urlResponse: HTTPURLResponse) -> Result<Any> {
        debugPrint("===== REST API: Success (HTTP code: \( urlResponse.statusCode)) =====")
        
        guard let data = data else {
            return .failure(CustomError.InvalidResponse)
        }
        
        switch urlResponse.statusCode {
        case 200 ... 299:
            return .success(data)
        case 401:
            return .failure(.APIKeyInvalid)
        default:
            return .failure(.Unknown)
        }
    }
}
