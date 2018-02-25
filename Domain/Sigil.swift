//
//  Sigil.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 24/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//
import UIKit

// MARK: - Protocol
protocol Sigil {
    var imageSigil:UIImage? {get}
    var descriptionSigil:DescriptionSigil {get}
}

// MARK: - Enum
enum DescriptionSigil: String {
    case Stark = "Lobo Huargo"
    case Lannister = "León rampante"
    case Targaryen = "Dragón Tricéfalo"
    
    static let values = [Stark, Lannister, Targaryen]
}

// MARK: - Class
final class SigilStark:Sigil{
    
    var imageSigil: UIImage?{
        get{
            return UIImage(assetIdentifier: .Stark)
        }
    }
    
    var descriptionSigil: DescriptionSigil{
        get{
            return .Stark
        }
    }
    
    class var instance:SigilStark{
        struct WrapperSingleton {
            static let instance = SigilStark()
        }
        return WrapperSingleton.instance
    }
    
}

final class SigilLannister:Sigil{
    
    var imageSigil: UIImage?{
        get{
            return UIImage(assetIdentifier: .Lannister)
        }
    }
    
    var descriptionSigil: DescriptionSigil{
        get{
            return .Lannister
        }
    }
    
    class var instance:SigilLannister{
        struct WrapperSingleton {
            static let instance = SigilLannister()
        }
        return WrapperSingleton.instance
    }
    
}


final class SigilTargaryen:Sigil{
    
    var imageSigil: UIImage?{
        get{
            return UIImage(assetIdentifier: .Targaryen)
        }
    }
    
    var descriptionSigil: DescriptionSigil{
        get{
            return .Targaryen
        }
    }
    
    class var instance:SigilTargaryen{
        struct WrapperSingleton {
            static let instance = SigilTargaryen()
        }
        return WrapperSingleton.instance
    }
    
}

/*
 * How to use instances class Sigil with pattern Singleton
 *
 * let s1:Sigil = SigilStark.instance
 * let des:String = s1.descriptionSigil.rawValue
 * ( or )
 * let des:DescriptionSigil = s1.descriptionSigil // Here is emun item
 * let img:UIImage = s1.imageSigil!
 */

