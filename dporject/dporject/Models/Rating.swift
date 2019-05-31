//
//  Rating.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 30/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct Rating{
    var userId: String?
    var value: Double?
    
    init(userId: String, value: Double) {
        self.userId = userId
        self.value = value
    }
    
    init(snapshot: AnyObject){
        self.userId = snapshot["userId"] as? String
        self.value = snapshot["value"] as? Double
    }
    
   
}
