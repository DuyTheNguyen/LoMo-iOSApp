//
//  Movie.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct Movie{
    let id: String
    let name: String
    let rating: String
    let year: String
    let image: String
    let genre: String
    let description: String
    let director: String
    
    init(pId: String, pName: String, pYear: String, pRating: String, pGenre: String, pImage: String, pDescription: String, pDirector:String)
    {
        id = pId
        name = pName
        rating = pRating
        year = pYear
        image = pImage
        genre = pGenre
        description = pDescription
        director = pDirector
    }
}
