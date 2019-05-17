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
}
