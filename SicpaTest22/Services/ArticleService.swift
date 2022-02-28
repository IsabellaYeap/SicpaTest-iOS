//
//  ArticleService.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

enum ArticleEndpoint {
    case indexOfViewed(params: RequestParameters?, path: String)
    case indexOfShared(params: RequestParameters?, path: String)
    case indexOfEmailed(params: RequestParameters?, path: String)
    case indexOfSearch(params: RequestParameters?)
}

extension ArticleEndpoint: RequestProtocol {
    var path: String {
        switch self {
        case .indexOfViewed(_, let path):
            return "mostpopular/v2/viewed/\(path).json"
        case .indexOfShared(_, let path):
            return "mostpopular/v2/shared/\(path).json"
        case .indexOfEmailed(_, let path):
            return "mostpopular/v2/emailed/\(path).json"
        case .indexOfSearch:
            return "search/v2/articlesearch.json"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .indexOfViewed,
                .indexOfShared,
                .indexOfEmailed,
                .indexOfSearch:
            return .get
        }
    }
    
    var headers: RequestHeaders? {
        return nil
    }
    
    var parameters: RequestParameters? {
        switch self {
        case .indexOfViewed(let params, _),
                .indexOfShared(let params, _),
                .indexOfEmailed(let params, _),
                .indexOfSearch(let params):
            return params
        }
    }
    
    var requestType: RequestType {
        return .data
    }
    
    var responseType: ResponseType {
        return .data
    }
}

class ArticleService: NSObject {
    func getListing(period: Period = .today, landingType: LandingType, completion: @escaping (Result<[ArticleModel]>) -> Void) {
        let dispatcher = APIRequestDispatcher(environment: APIEnvironment.Nytimes, networkSession: APINetworkSession())
        
        let params = [
            "api-key": AppSetting.nytimesApiKey
        ] as RequestParameters
        
        let endpoint: ArticleEndpoint? = {
            switch landingType {
            case .viewed:
                return ArticleEndpoint.indexOfViewed(params: params, path: String(period.rawValue))
            case .shared:
                return ArticleEndpoint.indexOfShared(params: params, path: String(period.rawValue))
            case .emailed:
                return ArticleEndpoint.indexOfEmailed(params: params, path: String(period.rawValue))
            default:
                return nil
            }
        }()
        
        guard let endpoint = endpoint else { return }
        
        let operation = APIOperation(endpoint)
        
        operation.execute(in: dispatcher) { (result) in
            switch result {
            case .data(let data, _):
                guard let result = JSONUtil.decode(data: data, ele: ArticleResult.self) else {
                    return
                }
                completion(.success(result.articles))
                break
            case .error(let error, _):
                completion(.failure(error))
                break
            }
        }
    }
    
    func searchListing(keyword: String, paging: Int, sort: SortOrder = .relevance, completion: @escaping (Result<[ArticleModel]>) -> Void) {
        let dispatcher = APIRequestDispatcher(environment: APIEnvironment.Nytimes, networkSession: APINetworkSession())
        
        let params = [
            "page": paging,
            "q": keyword,
            "sort": sort.rawValue,
            "api-key": AppSetting.nytimesApiKey
        ] as RequestParameters
        
        let endpoint = ArticleEndpoint.indexOfSearch(params: params)
        let operation = APIOperation(endpoint)
        
        operation.execute(in: dispatcher) { result in
            switch result {
            case .data(let data, _):
                guard let result = JSONUtil.decode(data: data, ele: SearchResult.self) else {
                    return
                }
                completion(.success(result.articles))
                break
            case .error(let error, _):
                completion(.failure(error))
                break
            }
        }
    }
    
}
