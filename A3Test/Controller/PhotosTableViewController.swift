//
//  PhotosTableViewController.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
   
    
    var userphotos:[Photo] = []
    var userAlbums:[Album] = []
    var firsAlbum = 0
    var cache = NSCache<NSString,AnyObject>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.cache.removeAllObjects()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userphotos.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
        let cellItem = userphotos[indexPath.row]
        cell.photoTitleLable.text = cellItem.title
        // in cashe
        if let imageURL = cache.object(forKey: cellItem.url as NSString)  {
        cell.photoView.image =  imageURL as? UIImage
        }  else  {
        // in outcCashe

            let url = URL(string: cellItem.url)
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
            networkManager.shared.getData(url: url!) { (data) in
            let image = UIImage(data: data as! Data)
            self.cache.setObject(image as AnyObject, forKey: cellItem.url as NSString)

                DispatchQueue.main.async  {
                cell.photoView.image = image
                cell.myActivityIndicator.stopAnimating()
                
                }
        }
            }
        }
        return cell
    }
        
    
    // Infinity scroling
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastitem = userphotos.count - 1
        if indexPath.row == lastitem {
        self.firsAlbum = self.firsAlbum + 1
            if self.firsAlbum <= (userAlbums.last?.id)! {
            getDataNetworkService.getPhotos(albumId: self.firsAlbum)  { (photosData) in
                self.userphotos.append(contentsOf: photosData.photos)
                DispatchQueue.main.async  {
                    self.tableView.reloadData()}}
            } else {return}
        }
    }

    
}


