//
//  SearchViewController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
//    MARK: IBOutlets
    
    @IBOutlet private var textField: UITextField!
    
    @IBOutlet private var searchButton: UIButton!
    
//    MARK: Variables
    
    private var searchingKeyword: String? {
        return textField.isNotNilOrEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SearchResultSegue":
            if let controller = segue.destination as? ListingViewController, let type = sender as? LandingType {
                controller.landingType = type
            }
            break
        default:
            break
        }
    }
    
//    MARK: Private Methods
    
    /// Initial setup view layout
    private func setupUI() {
        title = "Search"
    }
    
//    MARK: IBActions
    
    @IBAction func search(_ sender: UIButton) {
        guard let keyword = searchingKeyword else { return }
        
        performSegue(withIdentifier: "SearchResultSegue", sender: LandingType.search(keyword: keyword))
    }

}

extension UITextField {
    var isNotNilOrEmpty: String? {
        if let text = self.text, !text.isEmpty {
            return text
        }
        return nil
    }
}
