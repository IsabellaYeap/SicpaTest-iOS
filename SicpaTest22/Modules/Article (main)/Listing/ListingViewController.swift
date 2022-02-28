//
//  ListingViewController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import UIKit

class ListingViewController: UIViewController {
    
//    MARK: IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
//    MARK: Variables
    
    lazy var controller: ListingController = {
        return ListingController()
    }()
    
    lazy var viewModel: ListingViewModel = {
        return controller.viewModel
    }()
    
    var landingType: LandingType? = nil
    
    deinit {
        viewModel.rowViewModels.removeObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        controller.start(landingType: landingType)
        
        viewModel.rowViewModels.addObserver { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
//    MARK: Private Methods
    
    /// Initial setup view layout
    private func setupUI() {
        title = "Articles"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
    }

}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListingCell", for: indexPath)
        
        if let viewModel = controller.findRowViewModel(for: indexPath) as? ArticleRowViewModel {
            cell.textLabel?.text = viewModel.title
            cell.detailTextLabel?.text = viewModel.value
        }
        
        return cell
    }
}
