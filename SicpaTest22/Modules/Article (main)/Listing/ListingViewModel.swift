//
//  ListingViewModel.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

class ListingViewModel: NSObject {
    let rowViewModels = Observable<[RowViewModel]>(value: [])
}

class ArticleRowViewModel: RowViewModel {
    var title: String
    
    var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
