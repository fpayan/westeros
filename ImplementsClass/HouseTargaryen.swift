//
//  HouseTargaryen.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 24/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import Foundation

final class HouseTargaryen: HouseProtocol{
    
    // MARK: - Private
    private var _name:HouseNames
    private var _sigil:Sigil
    private var _works:HouseWorks
    private var _wikiURL:URL
    private var _members: Members
    
    // MARK: - Properties GET
    var name: HouseNames{
        return _name
    }
    
    var sigil: Sigil{
        return _sigil
    }
    
    var words: HouseWorks{
        return _works
    }
    
    var wikiURL: URL{
        return _wikiURL
    }
    
    // MARK: - Proxy
    var proxyForEquality: String{
        return "\(name.rawValue) \(words.rawValue)" //" \(count)"
    }
    
    var proxyForComparison: String{
        return name.rawValue.uppercased() // Alexander > Alexandre
    }
    
    // MARK: - Init
    private init(name:HouseNames, sigil:Sigil, works:HouseWorks, wikiURL:URL) {
        self._name = name
        self._sigil = sigil
        self._works = works
        self._wikiURL = wikiURL
        self._members = Members()
    }
    
    // MARK: - Creation Singleton
    class var instance:HouseTargaryen?{
        struct WrapperSingleton {
            static let url:String = HouseURL.Targaryen.rawValue
            static let singletonStark = HouseTargaryen(name: .Targaryen, sigil:SigilTargaryen.instance, works: .Targaryen, wikiURL:URL(string: url)!  )
        }
        return WrapperSingleton.singletonStark
    }
    
}

extension HouseTargaryen {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        /* Arreglar esto */
        guard person.house.name == self._name else {
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        // Aqui, persons es de tipo [Person]
        //        for person in persons {
        //            add(person: person)
        //        }
        persons.forEach{
            guard $0.house.name == self._name else{
                return
            }
            add(person: $0)
        }
    }
}

// MARK: - Equatable
extension HouseTargaryen: Equatable {
    static func ==(lhs: HouseTargaryen, rhs: HouseTargaryen) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension HouseTargaryen: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension HouseTargaryen: Comparable {
    static func <(lhs: HouseTargaryen, rhs: HouseTargaryen) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

