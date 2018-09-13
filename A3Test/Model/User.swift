//
//  User.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import Foundation


struct User:Decodable {

    var id: Int?
    var name: String?
    var albums: Int?
   
    
    init(id:Int,name:String) {
        
        self.id = id
        self.name = name
}
}
