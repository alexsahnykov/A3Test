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



    
init(id: Int, name: String) {
        self.id = id
        self.name = name
}
}


struct UserData:Decodable {
    var id: Int = 0
    var name: String = ""
}




struct GetUsers {
    var users: [user] = []

    init(data: Data) throws {
        let json = try JSONDecoder().decode(Array<UserData>.self, from: data)
        for object in  json  {
            let userForArray = user.init(id: object.id, name: object.name)
                 users.append(userForArray)}
            }
        } 



