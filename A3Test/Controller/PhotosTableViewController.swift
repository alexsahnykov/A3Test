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
    var cache = NSCache<NSString,AnyObject>()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        if let imageURL = cache.object(forKey: cellItem.url as NSString) as? URL {
            let data = try? Data (contentsOf: imageURL)
            cell.photoView.image =  UIImage(data: data!)
            print(imageURL)
        }  else {
        cell.photoTitleLable.text = cellItem.title
        cell.photoView.downloaded(from: cellItem.url)
            self.cache.setObject(cell.photoView.downloaded(from: cellItem.url) as AnyObject, forKey: cellItem.url as NSString)
            print(cell.photoView.downloaded(from: cellItem.url))
        }
        return cell
    }
   
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastitem = photos.count - 1
        if indexPath.row == lastitem {
        self.firsAlbum = self.firsAlbum + 1
            if self.firsAlbum <= (totalAlbums.last?.id)! {
            getDataNetworkService.getPhotos(albumId: self.firsAlbum)  { (photosData) in
                self.photos.append(contentsOf: photosData.photos)
                DispatchQueue.main.async  {
                    self.tableView.reloadData()}}
            } else {return}
        }
    }

    
}


extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
