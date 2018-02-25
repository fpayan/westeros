//
//  HouseProtocol.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 25/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import Foundation

protocol HouseProtocol {
    var name: HouseNames {get}
    var sigil: Sigil {get}
    var words: HouseWorks {get}
    var wikiURL: URL {get}
    var proxyForEquality: String {get}
    var proxyForComparison: String {get}
    
    typealias Words = String
    typealias Members = Set<Person>
    
}
