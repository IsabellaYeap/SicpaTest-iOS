//
//  ArticleModel.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

struct ArticleResult: Codable {
    let articles: [ArticleModel]
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        
        self.articles = try outerContainer.decode([ArticleModel].self, forKey: .results)
    }
}

struct SearchResult: Codable {
    let articles: [ArticleModel]
    
    enum DataKeys: String, CodingKey {
        case docs
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        let dataContainer = try outerContainer.nestedContainer(keyedBy: OuterKeys.self, forKey: .response)
        
        self.articles = try dataContainer.decode([ArticleModel].self, forKey: .docs)
    }
}

struct ArticleModel: Codable {
    let title: String?
    let datePublished: Date?
    
    enum DataKeys: String, CodingKey {
        case title
        case published_date
        case headline
        case pub_date
        case main
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: DataKeys.self)
        let dataContainer = try? outerContainer.nestedContainer(keyedBy: DataKeys.self, forKey: .headline)
        
        if let title = try? outerContainer.decodeIfPresent(String.self, forKey: .title) {
            self.title = title
        } else if let title = try? dataContainer?.decodeIfPresent(String.self, forKey: .main) {
            self.title = title
        } else {
            self.title = nil
        }
 
        if let date = try? outerContainer.decodeIfPresent(String.self, forKey: .published_date) {
            self.datePublished = date.toDate("yyyy-MM-dd")
        } else if let date = try? outerContainer.decodeIfPresent(String.self, forKey: .pub_date) {
            self.datePublished = date.toDate("yyyy-MM-dd'T'HH:mm:ss+0000")
        } else {
            self.datePublished = nil
        }
    }
}

extension ArticleModel {
    var displayedTitle: String {
//        return "displayedTitle"
        return title ?? ""
    }
    
    var displayedDate: String {
//        return "displayedDate"
        return datePublished?.toString("d MMM yyyy") ?? ""
    }
}


extension String {
    func toDate(_ dateFormat: String = "dd/MM/yy", setTimeZone: Bool = true) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if setTimeZone {
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        
        return formatter.date(from: self)
    }
}

extension Date {
    func toString(_ dateFormat: String = "dd/MM/YYYY", setTimeZone: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        if setTimeZone {
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        
        return formatter.string(from: self)
    }
}
