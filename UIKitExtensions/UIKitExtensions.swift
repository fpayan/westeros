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

// MARK: - UIImage
extension UIImage{
    enum AssetIdentifier: String {
        case GameDefault = "GameDefault"
        case Stark = "Stark"
        case StarkBig = "StarkBig"
        case Lannister = "Lannister"
        case LannisterBig = "LannisterBig"
        case Targaryen = "Targaryen"
        case TargaryenBig = "TargaryenBig"
        //
        case IconHouse = "House"
        case IconSeason = "Folder"
        case IconTv = "Tv"
        //
        case Member = "Member"
        
        static let values = [GameDefault, Stark, StarkBig, Lannister, LannisterBig, Targaryen, TargaryenBig, IconHouse, IconSeason, IconTv, Member]
    }
    
    convenience init!(assetIdentifier: AssetIdentifier){
        self.init(named: assetIdentifier.rawValue)
    }
}
