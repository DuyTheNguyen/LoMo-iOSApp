//
//  Genre.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct Genre: Decodable{
    let name: String?
    let image: String?
    
    init(name: String, image: String){
        self.name = name
        self.image = image
       
    }
    
    init(snapshot: AnyObject){
        self.name = snapshot["name"] as? String
        self.image = snapshot["image"] as? String
    }
}
