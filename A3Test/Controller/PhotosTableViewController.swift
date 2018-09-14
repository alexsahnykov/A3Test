//
//  PhotosTableViewController.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    var albums:[Album] = []
    var photos:[Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
      //  print(albums)
        for object in albums {
            getDataNetworkService.getPhotos(userId: object.id!) { (photosData) in
            self.photos = photosData.photos+self.photos
                DispatchQueue.main.async  {
                    self.tableView.reloadData()}
            }
    }
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
        return cell
    }

}
