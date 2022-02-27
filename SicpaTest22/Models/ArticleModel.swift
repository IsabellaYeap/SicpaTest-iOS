//
//  ArticleModel.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

struct ArticleModel: Codable {
    let title: String
    let datePuslished: Date
}

extension ArticleModel {
    var displayedTitle: String {
        return "displayedTitle"
    }
    
    var displayedDate: String {
        return "displayedDate"
    }
}
