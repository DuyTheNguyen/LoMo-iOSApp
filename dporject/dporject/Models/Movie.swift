//
//  Movie.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct Movie: Decodable{
    let id: String?
    let name: String?
    let rating: String?
    let year: String?
    let image: String?
    let genre: String?
    let description: String?
    let director: String?
    let cinemas: [String]?
    
    init(id: String? = nil,
         name: String? = nil,
         rating: String? = nil,
         year: String? = nil,
         image: String? = nil,
         genre:String? = nil,
         description:String? = nil,
         director:String? = nil,
         cinemas:[String]? = nil
         ){
        self.id = id
        self.name = name
        self.rating = rating
        self.year = year
        self.image = image
        self.genre = genre
        self.description = description
        self.director = director
        self.cinemas = cinemas
    }
    
    init(snapshot: AnyObject){
        self.id = snapshot["id"] as? String
        self.name = snapshot["name"] as? String
        self.rating = snapshot["rating"] as? String
        self.year = snapshot["year"] as? String
        self.image = snapshot["image"] as? String
        self.genre = snapshot["genre"] as? String
        self.description = snapshot["description"] as? String
        self.director = snapshot["director"] as? String
        if let dic = snapshot["cinemas"] as? [String: AnyObject] {
            self.cinemas = [String]()
            for (key, _) in dic{
                self.cinemas?.append(key)
            }
        } else{
            self.cinemas = nil
        }
    }
}
