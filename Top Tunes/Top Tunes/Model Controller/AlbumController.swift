//
//  AlbumController.swift
//  Top Tunes
//
//  Created by Mitchell Budge on 3/3/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    let baseURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json/")
    
    func fetchAlbums(completion: @escaping (Result<Album, Error>) -> Void) {
        
        guard let requestURL = baseURL else { return }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error fetching albums: \(error)")
                completion(.failure(error))
                return
            }
            guard let albumData = data else {
                print("Error retrieving data from data task")
                completion(.failure(NSError()))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.albums = try decoder.decode([Album].self, from: albumData)
                print(self.albums.count)
            } catch {
                print("Error decoding data to type Album: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
}
