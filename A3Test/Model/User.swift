//
//  User.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import Foundation


struct user {

    var id: Int = 0
    var name: String = ""
    var albums: [Album] = []
    
    
init(id: Int, name: String, albums: [Album]) {
        self.id = id
        self.name = name
        self.albums = albums
    }
}



struct UserData:Decodable {
    var id: Int = 0
    var name: String = ""
}




class GetUsers {
    var users: [user] = []

    init(data: Data) throws {
        let json = try JSONDecoder().decode(Array<UserData>.self, from: data)
        for object in  json  {
            let userForArray = user.init(id: object.id, name: object.name, albums: [])
                 users.append(userForArray)}
            }
        } 


