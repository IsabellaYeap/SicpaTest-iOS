//
//  ListingViewModel.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

class ListingViewModel: NSObject {
    let sectionViewModels = Observable<[SectionViewModel]>(value: [])
}
