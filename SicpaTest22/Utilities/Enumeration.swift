//
//  Enumeration.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

public enum Period: Int {
    case today = 1
    case thisWeek = 7
    case thisMonth = 30
}

public enum ShareType: String {
    case facebook
}

public enum SortOrder: String {
    case newest
    case oldest
    case relevance
}

public enum LandingSection {
    case search (row: [LandingType])
    case popular (row: [LandingType])
    
    var title: String {
        switch self {
        case .search:
             return "Search"
        case .popular:
            return "Popular"
        }
    }
}

public enum LandingType {
    case search(keyword: String = "")
    case viewed
    case shared
    case emailed
    
    var title: String {
        switch self {
        case .search:
            return "Search Articles"
        case .viewed:
            return "Most Viewed"
        case .shared:
            return "Most Shared"
        case .emailed:
            return "Most Emailed"
        }
    }
}
