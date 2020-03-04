//
//  Album.swift
//  Top Tunes
//
//  Created by Mitchell Budge on 3/3/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let albumName: String
    let artistName: String
    let artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case feed
        case results
        case albumName
        case artistName
        case artworkURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let feedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .feed)
        var resultsContainer = try feedContainer.nestedUnkeyedContainer(forKey: .results)
        let albumContainer = try resultsContainer.nestedContainer(keyedBy: CodingKeys.self)
        albumName = try albumContainer.decode(String.self, forKey: .albumName)
        artistName = try albumContainer.decode(String.self, forKey: .artistName)
        artworkURL = try albumContainer.decode(URL.self, forKey: .artworkURL)
    }
    
}
