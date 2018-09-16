//
//  NetworkManager.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import Foundation
import UIKit


class networkManager {
    private init() {}
    
    static let shared = networkManager()
    
    func getData(url: URL, completionHandler: @escaping (Any) -> ()) {
    let session = URLSession.shared
    
    session.dataTask(with: url) { (data, response, error) in
    guard let data = data else {
        
        print((error?.localizedDescription)!)
        CustomAlert.init(title: "Error", subTitle: (error?.localizedDescription)!).alertController()
        return }
    completionHandler(data)
    }.resume()
    }
}



class getDataNetworkService {
    private init() {}

  
    
    
    static func getUsers(completion: @escaping(GetUsers) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        networkManager.shared.getData(url: url) { (data) in
            do {
                let users = try GetUsers(data: data as! Data)
                completion(users)
            } catch {
                print(error)
            }
        }
    }



    static func getAlbums(userId:Int, completion: @escaping(GetAlbums) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/"+"\(userId)"+"/albums") else { return }
        
        networkManager.shared.getData(url: url) { (data) in
            do {
                let albumsData = try GetAlbums(data: data as! Data)
               completion(albumsData)
            } catch {
                print(error)
            }
        }
    }
    static func getPhotos(albumId:Int, completion: @escaping(GetPhotos) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums/"+"\(albumId)"+"/photos") else { return }
        networkManager.shared.getData(url: url) { (data) in
            do {
                let photosData = try GetPhotos(data: data as! Data)
           completion(photosData)
            } catch {
                print(error)
            }
        }
    }
  


}

