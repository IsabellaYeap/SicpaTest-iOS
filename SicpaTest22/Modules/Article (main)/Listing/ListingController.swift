//
//  ListingController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

class ListingController: NSObject {
    
//    MARK: Parameters
    let viewModel: ListingViewModel
    
    let landingType: LandingType
    
    init(viewModel: ListingViewModel = ListingViewModel(), landingType: LandingType) {
        self.viewModel = viewModel
        self.landingType = landingType
    }
    
    
}
