//
//  LandingController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

class LandingController {
    
//    MARK: Variable
    
    let viewModel: LandingViewModel
    
    let sections: [LandingSection]
    
//    MARK: Initial
    
    init(viewModel: LandingViewModel = LandingViewModel()) {
        self.viewModel = viewModel
        self.sections = [.search(row: [.search()]), .popular(row: [.viewed, .shared, .emailed])]
    }
    
//    MARK: Methods
    
    /// Return the count rows of specifix section
    /// - Parameter section: Section indexes
    /// - Returns: Total count
    func numberOfRow(for section: Int) -> Int {
        let landingSection = sections[section]
        switch landingSection {
        case .search(let row), .popular(let row):
            return row.count
        }
    }
    
    /// Return header title of specifix section
    /// - Parameter section: Section Indexes
    /// - Returns: Text
    func headerOfSection(for section: Int) -> String {
        let landingSection = sections[section]
        return landingSection.title
    }
    
    /// Find ranking type for specific row
    /// - Parameter indexPath: item indexes from listing
    /// - Returns: data view model
    func findLandingType(for indexPath: IndexPath) -> LandingType {
        let landingSection = sections[indexPath.section]
        switch landingSection {
        case .search(let row), .popular(let row):
            return row[indexPath.row]
        }
    }
}
