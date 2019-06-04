//
//  CommentService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class CommentService: BaseDatabaseNetworkController, ServiceFactory{
  
    
    
    weak var delegate: ObservationDelegate?
    
    
    func add(path: String, object: Any) -> Bool{
        let comment = object as! Comment
        let commentRef = rootReference.child("\(Paths.COMMENTS)/\(path)").childByAutoId()
        commentRef.setValue([
            "commentId" : commentRef.key,
            "userId": comment.userId,
            "userName": comment.userName,
            "image" : comment.image,
            "timestamp" : comment.timestamp,
            "content": comment.content
            ])
        return true
    }
    
    func delete(path: String) {
        
    }
    
    func observe(path:String)->[Comment]{
        var comments = [Comment]()
        rootReference.child(path).observe(.value) { (snapshot) in
            guard let values = snapshot.value as? [String:AnyObject] else {
                print("Could not load list of objects or empty list")
                return
            }
          
          
            for (_,value) in values{
                let comment = Comment(snapshot: value)
                comments.append(comment)
            }
            
           
        }
        return comments
    }
    
    
    func getListOfObject(path: String) -> [Any]{
        let objects = [Any]()
        return objects
    }
    
    func getSingleObject(path: String){
    }
}
