//
//  LandingController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

class LandingController {
    
//    MARK: Parameters
    let viewModel: LandingViewModel
    
    let sections: [LandingSection]
    
    init(viewModel: LandingViewModel = LandingViewModel()) {
        self.viewModel = viewModel
        self.sections = [.search(row: [.search()]), .popular(row: [.viewed, .shared, .emailed])]
    }
}
