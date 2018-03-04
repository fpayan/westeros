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
    typealias FilterSesion = (SeasonProtocol) -> Bool
    typealias FilterEpisode = (EpisodeProtocol) -> Bool
    
    var houses: [HouseProtocol] { get }
    var seasons:[SeasonProtocol]{ get }
    var episodes:[EpisodeProtocol]{ get }
    
    func house(named name: String) -> HouseProtocol?
    func houses(filteredBy: Filter) -> [HouseProtocol]
    
    func season(named name: String) -> SeasonProtocol?
    func seasons(filteredBy: FilterSesion) -> [SeasonProtocol]
    
    func episode(named name: String) -> EpisodeProtocol?
    func episodes(filteredBy: FilterEpisode) -> [EpisodeProtocol]
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
        let daniJunior = Person(name: "Daenerys Junior", alias: "Daughter de Dragones", house: targaryenHouse!)
        
        // Add characters to houses
        starkHouse?.add(person: arya)
        starkHouse?.add(person: robb)
        lannisterHouse?.add(person: tyrion)
        lannisterHouse?.add(person: cersei)
        lannisterHouse?.add(person: jaime)
        targaryenHouse?.add(person: dani)
        targaryenHouse?.add(person: daniJunior)
        
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
    
    // MARK: - Seasons
    var seasons:[SeasonProtocol]{
        
        let season1:SeasonProtocol = Season(sesionID: 1, name: "Season one", dateLaunch: Date(dateString: "2010/01/12") )
        
        let season2:SeasonProtocol = Season(sesionID: 2, name: "Season two", dateLaunch: Date(dateString: "2011/01/12") )
        
        let season3:SeasonProtocol = Season(sesionID: 3, name: "Season trhee", dateLaunch: Date(dateString: "2012/01/12") )
        
        let season4:SeasonProtocol = Season(sesionID: 4, name: "Season four", dateLaunch: Date(dateString: "2013/01/12") )
        
        let season5:SeasonProtocol = Season(sesionID: 5, name: "Season five", dateLaunch: Date(dateString: "2014/01/12") )
        
        let season6:SeasonProtocol = Season(sesionID: 6, name: "Season six", dateLaunch: Date(dateString: "2015/01/12") )
        
        let season7:SeasonProtocol = Season(sesionID: 7, name: "Season seven", dateLaunch: Date(dateString: "2016/01/12") )
        
        let season8:SeasonProtocol = Season(sesionID: 8, name: "Season eight", dateLaunch: Date(dateString: "2017/01/12") )
        // return GET
        return [season1, season2, season3, season4, season5, season6, season7, season8]
    }
    
    
    
    func season(named dateString: String) -> SeasonProtocol? {
        let season:SeasonProtocol = seasons.filter{ $0.dateLaunch == Date(dateString: dateString ) }.first!
        //
        return season
    }
    
    func seasons(filteredBy: (SeasonProtocol) -> Bool) -> [SeasonProtocol] {
        return Repository.local.seasons.filter(filteredBy)
    }
    
    
    // Episode repo
    var episodes:[EpisodeProtocol]{
        
        let episode1temp1:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp one", dateToEmit: Date(dateString:"2010/01/15"), season: seasons[0])
        let episode2temp1:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp one", dateToEmit: Date(dateString:"2010/08/15"), season: seasons[0])
        
        let episode1temp2:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp two", dateToEmit: Date(dateString:"2011/01/15"), season: seasons[1])
        let episode2temp2:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp two", dateToEmit: Date(dateString:"2011/08/15"), season: seasons[1])
        
        let episode1temp3:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp trhee", dateToEmit: Date(dateString:"2012/01/15"), season: seasons[2])
        let episode2temp3:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp trhee", dateToEmit: Date(dateString:"2012/08/15"), season: seasons[2])
        
        let episode1temp4:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp four", dateToEmit: Date(dateString:"2013/01/15"), season: seasons[3])
        let episode2temp4:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp four", dateToEmit: Date(dateString:"2013/08/15"), season: seasons[3])
        
        let episode1temp5:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp five", dateToEmit: Date(dateString:"2014/01/15"), season: seasons[4])
        let episode2temp5:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp five", dateToEmit: Date(dateString:"2014/08/15"), season: seasons[4])
        
        let episode1temp6:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp six", dateToEmit: Date(dateString:"2015/01/15"), season: seasons[5])
        let episode2temp6:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp six", dateToEmit: Date(dateString:"2015/08/15"), season: seasons[5])
        
        let episode1temp7:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp seven", dateToEmit: Date(dateString:"2016/01/15"), season: seasons[6])
        let episode2temp7:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp seven", dateToEmit: Date(dateString:"2016/08/15"), season: seasons[6])
        
        let episode1temp8:EpisodeProtocol = Episode(episodeID: 1, title: "Title episode one temp eight", dateToEmit: Date(dateString:"2017/01/15"), season: seasons[7])
        let episode2temp8:EpisodeProtocol = Episode(episodeID: 2, title: "Title episode two temp eight", dateToEmit: Date(dateString:"2017/08/15"), season: seasons[7])
        
        // return GET
        return [
            episode1temp1, episode2temp1,
            episode1temp2, episode2temp2,
            episode1temp3, episode2temp3,
            episode1temp4, episode2temp4,
            episode1temp5, episode2temp5,
            episode1temp6, episode2temp6,
            episode1temp7, episode2temp7,
            episode1temp8, episode2temp8
        ]
    }
    
    func episode(named dateString: String) -> EpisodeProtocol? {
        let episode:EpisodeProtocol = episodes.filter{ $0.dateToEmit == Date(dateString: dateString )  }.first!
        //
        return episode
    }
    
    func episodes(filteredBy: (EpisodeProtocol) -> Bool) -> [EpisodeProtocol] {
        return Repository.local.episodes.filter(filteredBy)
    }
    
}





