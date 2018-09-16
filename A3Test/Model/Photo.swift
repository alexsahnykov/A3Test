//
//  Photo.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import Foundation


struct Photo:Decodable {
    
    var albumId: Int
    var id: Int
    var title: String
    var url:String
    var thumbnailUrl:String
    
    
}
struct GetPhotos {
    var photos: [Photo] = []
    
    init(data: Data) throws {
        let json = try JSONDecoder().decode(Array<Photo>.self, from: data)
        for object in json {
            self.photos.append(object)}
        
}
}
