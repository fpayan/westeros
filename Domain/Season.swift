//
//  Season.swift
//  Westeros
//
//  Created by Francisco Payán Calero on 20/2/18.
//  Copyright © 2018 Francisco Payán Calero. All rights reserved.
//

import Foundation

// MARK: - Season Protocol
protocol SeasonProtocol:SeasonProtocolClass {
    // typealias for add episodes always different
    typealias Episodes = Set<Episode>
    // Properties GET
    var name:String{get}
    var sesionID: Int{get}
    var dateLaunch:Date{get}
    // func for Episode
    func addEpisode(episode: EpisodeProtocol)
    func addEpisode(episodes: EpisodeProtocol...)
    func sortedEpisodes() -> [EpisodeProtocol]
    func findEpisode(title: String) -> EpisodeProtocol!
    
}
//
protocol SeasonProtocolClass: class{
    weak var episodeSeason:Episode?{get}
}

// MARK: - Season Class
final class Season:SeasonProtocol{
    
    var name: String
    var dateLaunch: Date
    var sesionID: Int
    private var _episodes:Episodes
    
    var episodeSeason: Episode?
    
    init(sesionID: Int, name:String, dateLaunch:Date) {
        self.sesionID = sesionID
        self.name = name
        self.dateLaunch = dateLaunch
        //
        self._episodes = Episodes()
    }
    
}


extension Season {
    /// This variable return the number of episodes in this season.
    var count : Int {
        return _episodes.count
    }
    
    /**
     This func add new episode intro `Set` of `Episodes`
     
     - parameters:
         - episode: An Episode for add at **Set<Episode>**
     
    */
    func addEpisode(episode: EpisodeProtocol) {
        // Returns: `true` if `member` exists in the set; otherwise, `false`.
        // Convert it's force. !
        guard !_episodes.contains(episode as! Episode) else {
            return
        }
        // Episode don't exist in Set<Episode>
        _episodes.insert(episode as! Episode)
    }
    
    /**
     Add array of Episodes intro `Set` of `Episode`
     
     - parameters:
        - episodes: Array of Episode witch parent's EpisodeProtocol
    */
    func addEpisode(episodes: EpisodeProtocol...){
        for episode in episodes{
            addEpisode(episode: episode)
        }
    }
    
    /**
     Sorted [EpisodeProtocol] from Set<Episode> give an Array() init
     
     ```
     episodesArray.sorted(by: {$0.title < $1.title })
     ```
     
     - return: Array of Episode for `title` propertie
    */
    func sortedEpisodes() -> [EpisodeProtocol]{
        let episodesArray : [EpisodeProtocol] = Array(_episodes)
        return episodesArray.sorted(by: {$0.title.uppercased() < $1.title.uppercased() })
    }
    
    /**
     Find episode intro Set<Episode>
     
     - parameters:
        - title: String give for search for title episode.
    */
    func findEpisode(title: String) -> EpisodeProtocol!{
        return _episodes.filter{ $0.title.uppercased() == title.uppercased() }.first
    }
}

// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}


