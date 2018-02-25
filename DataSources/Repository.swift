//
//  Repository.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 20/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    
    typealias Filter = (HouseProtocol) -> Bool
    
    var houses: [HouseProtocol] { get }
    func house(named name: String) -> HouseProtocol?
    func houses(filteredBy: Filter) -> [HouseProtocol]
}

final class LocalFactory: HouseFactory {
    var houses: [HouseProtocol]{
        // Houses creation here
        
        // The Sigiles
//        let starkSigil:Sigil = SigilStark.instance
//        let lannisterSigil:Sigil = SigilLannister.instance
//        let targaryenSigil:Sigil = SigilTargaryen.instance
        
        // The Houses
        let starkHouse = HouseStark.instance
        let lannisterHouse = HouseLannister.instance
        let targaryenHouse = HouseTargaryen.instance
        
        // the Persons
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse!)
        let arya = Person(name: "Arya", house: starkHouse!)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse!)
        let cersei = Person(name: "Cersei", house: lannisterHouse!)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse!)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse!)
        
        
        // Add characters to houses
        starkHouse?.add(person: arya)
        starkHouse?.add(person: robb)
        lannisterHouse?.add(person: tyrion)
        lannisterHouse?.add(person: cersei)
        lannisterHouse?.add(person: jaime)
        targaryenHouse?.add(person: dani)
        
        return [starkHouse!, lannisterHouse!, targaryenHouse!].sorted(by: { ($0 ).name.rawValue < ($1 ).name.rawValue } )
        
    }
    
    func house(named name: String) -> HouseProtocol? {
        let house = houses.filter{ $0.name.rawValue.uppercased() == name.uppercased() }.first
        //let house = houses.first{ $0.name.uppercased() == name.uppercased() }
        return house
    }
    
    func houses(filteredBy: (HouseProtocol) -> Bool) -> [HouseProtocol] {
        return Repository.local.houses.filter(filteredBy)
    }
    


}


    
    

