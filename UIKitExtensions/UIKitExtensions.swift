//
//  UIKitExtensions.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 20/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

extension UIImage{
    enum AssetIdentifier: String {
        case GameDefault = "GameDefault"
        case Stark = "Stark"
        case StarkBig = "StarkBig"
        case Lannister = "Lannister"
        case LannisterBig = "LannisterBig"
        case Targaryen = "Targaryen"
        case TargaryenBig = "TargaryenBig"
        
        static let values = [GameDefault, Stark, StarkBig, Lannister, LannisterBig, Targaryen, TargaryenBig]
    }
    
    convenience init!(assetIdentifier: AssetIdentifier){
        self.init(named: assetIdentifier.rawValue)
    }
}
