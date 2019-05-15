//
//  Comment.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 15/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct Comment: Decodable{
    let commentId: String
    let userId: String
    let userName: String
    let image: String
    let content: String
    let timestamp: String
}
