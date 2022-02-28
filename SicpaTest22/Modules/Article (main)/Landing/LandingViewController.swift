//
//  LandingViewController.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import UIKit

class LandingViewController: UIViewController {
    
//    MARK: IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
//    MARK: Variables
    
    lazy var controller: LandingController = {
       return LandingController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ArticleViewSegue":
            if let controller = segue.destination as? ListingViewController, let type = sender as? LandingType {
                controller.landingType = type
            }
            break
        default:
            break
        }
    }
    
//    MARK: Private Methods
    
    private func setupUI() {
        title = "NYT"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
    }
    
}

extension LandingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return controller.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numberOfRow(for: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return controller.headerOfSection(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandingTypeCell", for: indexPath)
        
        let landingType = controller.findLandingType(for: indexPath)
        cell.textLabel?.text = landingType.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let landingType = controller.findLandingType(for: indexPath)
        switch landingType {
        case .search:
            performSegue(withIdentifier: "SearchViewSegue", sender: landingType)
        case .viewed, .shared, .emailed:
            performSegue(withIdentifier: "ArticleViewSegue", sender: landingType)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
