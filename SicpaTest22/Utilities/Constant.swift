//
//  Constant.swift
//  SicpaTest22
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import UIKit

struct Colors {
    static let primary : UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.8901960784, green: 0.4823529412, blue: 0.2274509804, alpha: 1) : #colorLiteral(red: 0.8941176471, green: 0.4823529412, blue: 0.2235294118, alpha: 1)
        }
    }()
    
    static let secondary : UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9098039216, green: 0.137254902, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.9098039216, green: 0.137254902, blue: 0.1882352941, alpha: 1)
        }
    }()
    
    static let background : UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9137254902, alpha: 1) : #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9137254902, alpha: 1)
        }
    }()
    
    static let lineSeparator : UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1) : #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
        }
    }()
    
    static let blackTextColor : UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }()
    
    static let whiteTextColor : UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }()
}

struct AppSetting {
    static let nytimesApiKey = "hMfaRA15Bt3AC1cIwhiPcB1bkNlsZ64Y"
}

protocol ViewModelPressible {
    var cellPressed: (() -> Void)? { get set }
}

protocol SectionViewModel {
    var key: String { get set }
    var rowViewModels: [RowViewModel] { get set }
}

protocol RowViewModel {
    var title: String { get set }
    var value: String { get set }
}
