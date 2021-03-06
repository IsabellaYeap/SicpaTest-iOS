//
//  ListingController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import Foundation

class ListingController: NSObject {
    
//    MARK: Variable
    
    let viewModel: ListingViewModel
    
    var landingType: LandingType? = nil {
        didSet {
            if let landingType = landingType {
                fetchListing(for: landingType)
            }
        }
    }
    
//    MARK: Initial
    
    init(viewModel: ListingViewModel = ListingViewModel()) {
        self.viewModel = viewModel
    }
    
//    MARK: Private Methods
    
    /// Data binding for notify view update and data source in view model.
    /// - Parameter article: A list of ArticleModel's data model
    private func convertToSectionViewModel(for article: [ArticleModel]) {
        var rowViewModels: [RowViewModel] = []
        article.forEach { article in
            rowViewModels.append(ArticleRowViewModel(title: article.displayedTitle, value: article.displayedDate))
        }
        viewModel.rowViewModels.value = rowViewModels
    }
    
//    MARK: Methods
    
    /// Start load data based on method of article ranking.
    /// - Parameter landingType: Ranking method in article listing, like most viewed.
    func start(landingType: LandingType?) {
        self.landingType = landingType
    }
    
    /// Find  view model for specific row
    /// - Parameter indexPath: item indexes from listing
    /// - Returns: data view model
    func findRowViewModel(for indexPath: IndexPath) -> RowViewModel {
        let rowViewModel = viewModel.rowViewModels.value[indexPath.row]
        return rowViewModel
    }
}

extension ListingController {
    
    /// Fetch data from api based on ranking method
    /// - Parameter type: Ranking method in article listing, like most viewed.
    func fetchListing(for type: LandingType) {
        switch type {
        case .search(let keyword):
            ArticleService().searchListing(keyword: keyword, paging: 0) { [weak self] result in
                switch result {
                case .success(let article):
                    self?.convertToSectionViewModel(for: article)
                    debugPrint(article)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            break
        case .emailed, .shared, .viewed:
            ArticleService().getListing(landingType: type) { [weak self] result in
                switch result {
                case .success(let article):
                    self?.convertToSectionViewModel(for: article)
                    debugPrint(article)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            break
        }
    }
    
}
