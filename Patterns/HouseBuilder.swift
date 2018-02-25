//
//  HouseBuilder.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 24/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//
//  This it's just a test of Builder pattern.
//

import Foundation

enum HouseTypeName:String{
    case Stark = "Stark"
    case Lannister = "Lannister"
    case Targaryen = "Targaryen"
}

//typealias Words = String

class HouseBuilder {
    
    private var name: String?
    private var sigil: Sigil?
    private var words: Words?
    private var wikiURL: URL?
    
    init(){
        // do nothing
    }
    
    func setName(name:String)->HouseBuilder{
        self.name = name
        return self
    }
    
    func setSigil(sigil:Sigil)->HouseBuilder{
        self.sigil = sigil
        return self
    }
    
    func setWords(words:Words)->HouseBuilder{
        self.words = words
        return self
    }
    
    func setWikiURL(urlWiki: URL)->HouseBuilder{
        self.wikiURL = urlWiki
        return self
    }
    
    
//    class func getBuilderHouse(houseType: HouseTypeName) -> HouseBuilder{
//        var builder: HouseBuilder
//        switch houseType {
//        case .Stark:
//            builder = HouseStark()
//        case .Lannister:
//            builder = HouseLannister()
//        case .Targaryen:
//            builder = HouseTargaryen()
//        }
//        return builder
//    }
    
}


