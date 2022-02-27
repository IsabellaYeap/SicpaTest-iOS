//
//  ArticleService.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

enum ArticleEndpoint {
    case indexOfViewed(params: RequestParameters, path: String)
    case indexOfShared(params: RequestParameters, path: String)
    case indexOfEmailed(params: RequestParameters, path: String)
    case indexOfSearch(params: RequestParameters)
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
                .indexOfEmailed:
            return .get
        case .indexOfSearch:
            return .post
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
    
}
