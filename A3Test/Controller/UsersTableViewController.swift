//
//  UsersTableViewController.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var usersForTable:[user] = []
     var photos:[Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataNetworkService.getUsers { (users) in
            self.usersForTable = users.users
                for objc in self.usersForTable {
                    getDataNetworkService.getAlbums(userId: objc.id) { (albumsData) in
                     self.usersForTable[objc.id-1].albums = albumsData.albums
                        DispatchQueue.main.async  {
                            self.tableView.reloadData()}
                }
            }
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
       super.viewWillAppear(true)
        self.photos.removeAll()

    }

    //  Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  usersForTable.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let object = usersForTable[indexPath.row]
        getDataNetworkService.getPhotos(albumId: (object.albums.first?.id)!) { (photosData) in
            self.photos.append(contentsOf: photosData.photos)
                DispatchQueue.main.async  {
                            self.performSegue(withIdentifier: "fromUserToPhoto", sender: self)
        }
    }
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) 
        let cellItem = usersForTable[indexPath.row]
        cell.textLabel?.text = cellItem.name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "fromUserToPhoto" {
        let dvc = segue.destination as! PhotosTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
        let object = usersForTable[indexPath.row]
            dvc.photos = self.photos
            dvc.totalAlbums = object.albums
            dvc.firsAlbum = (object.albums.first?.id)!
        }
}
}
}

