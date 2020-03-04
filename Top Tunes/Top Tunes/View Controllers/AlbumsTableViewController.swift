//
//  AlbumsTableViewController.swift
//  Top Tunes
//
//  Created by Mitchell Budge on 3/4/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    // MARK: - Properties
    
    let albumController = AlbumController()
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumController.fetchAlbums { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let album = albumController.albums[indexPath.row]
        guard let imageData = try? Data(contentsOf: album.artworkURL) else { return UITableViewCell() }
        cell.imageView?.image = UIImage(data: imageData)
        cell.textLabel?.text = album.albumName
        cell.detailTextLabel?.text = album.artistName
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
