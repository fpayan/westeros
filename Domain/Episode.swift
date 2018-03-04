//
//  Episode.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 20/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import Foundation

protocol EpisodeProtocol: EpisodeProtocolClass {
    // Properties GET
    var title:String{get}
    var dateToEmit:Date{get}
    var episodeID:Int{get}
    
    // func for manager Episode and Season
    func findEpisode(title:String)->EpisodeProtocol?
}

protocol EpisodeProtocolClass: class{
    weak var season:SeasonProtocol?{get} //Temporada
}

final class Episode:EpisodeProtocol{
    
    let season: SeasonProtocol?
    let title: String
    let dateToEmit: Date
    let episodeID: Int
    
    init(episodeID: Int, title:String, dateToEmit:Date, season:SeasonProtocol?) {
        self.episodeID = episodeID
        self.title = title
        self.dateToEmit = dateToEmit
        self.season = season
        // Add from here a new Episode at his have Sesion.
        if let temp = self.season {
            temp.addEpisode(episode: self)
        }
        
    }
}

extension Episode{
    /**
     Find episode intro season set.
     
     - parameter title: String give for search an Episode for his title.
     
     - returns: Episode with __title__ give how to parameters.
    */
    func findEpisode(title:String)->EpisodeProtocol?{
        return self.season?.findEpisode(title: title)
    }
}


// MARK: - Proxy
extension Episode {
    var proxyForEquality: String {
        return "\(episodeID)\(title.uppercased())"
    }
    
    var proxyForComparison: String {
        return title.uppercased()
    }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}



/*
 let dateformatter = DateFormatter()
 dateformatter.dateStyle = DateFormatter.Style.short
 dateformatter.timeStyle = DateFormatter.Style.short
 let date = dateformatter.string(from: Date())
 */
