//
//  Comment.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 15/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

struct Comment{
    var commentId: String!
    var userId: String!
    var userName: String!
    var image: String!
    var content: String!
    var timestamp: String!
    
    init(commentId: String, userId: String, userName: String, image: String, content: String, timestamp: String){
        self.commentId = commentId
        self.userId = userId
        self.image = image
        self.content = content
        self.timestamp = timestamp
        self.userName = userName
    }
    
    init(snapshot: AnyObject){
        self.commentId = snapshot["commentId"] as? String
        self.userId = snapshot["userId"] as? String
        self.image = snapshot["image"] as? String
        self.content = snapshot["content"] as? String
        self.timestamp = snapshot["timestamp"] as? String
        self.userName = snapshot["userName"] as? String
    }
}
