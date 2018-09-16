//
//  PhotosTableViewController.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    var photos:[Photo] = []
    var totalAlbums:[Album] = []
    var firsAlbum = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        print(self.totalAlbums)
        self.tableView.reloadData()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        let cellItem = photos[indexPath.row]
        cell.photoTitleLable.text = cellItem.title
        cell.mainBack.layer.cornerRadius = 10
        
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastitem = photos.count - 1
        if indexPath.row == lastitem {
        self.firsAlbum = self.firsAlbum + 1
            if self.firsAlbum <= (totalAlbums.last?.id)! {
            getDataNetworkService.getPhotos(albumId: self.firsAlbum)  { (photosData) in
                self.photos.append(contentsOf: photosData.photos)
                print(photosData.photos)
                DispatchQueue.main.async  {
                    self.tableView.reloadData()
                }
        }
            } else {return}
        }
}
}
