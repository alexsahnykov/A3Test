//
//  Albums.swift
//  A3Test
//
//  Created by Александр Сахнюков on 14/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import Foundation


struct Album:Decodable {
    
    var id: Int?
    var userId: Int?
    
    
   
}
struct GetAlbums {
    var albums: [Album] = []
    
    init(data: Data) throws {
        let json = try JSONDecoder().decode(Array<Album>.self, from: data)
        for object in json {
            self.albums.append(object)}
}
}
