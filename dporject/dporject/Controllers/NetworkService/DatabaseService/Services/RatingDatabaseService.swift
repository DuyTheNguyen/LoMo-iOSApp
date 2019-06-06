//
//  RatingService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class RatingDatabaseService:BaseDatabaseService, DatabaseServiceProtocol{
    
    func add(path: String, object: Any) -> Bool{
        let rating = object as! Rating
        let ratingRef = rootReference.child("\(Paths.RATING)").child(path).child(rating.userId!)
        ratingRef.setValue([
            "userId": rating.userId!,
            "value": rating.value!
            ])
        return true
    }
    
    func delete(path: String) {
        
    }
    
    func observe(path: String, completion: @escaping ObjectsCompletionHandler) {
        rootReference.child(path).observe(.value) { (snapshot) in
            guard let values = snapshot.value as? [String:AnyObject] else {
                print("Could not load list of objects or empty list")
                return
            }
            var ratings = [Rating]()
            for(_,value) in values{
                let rating = Rating(snapshot: value)
                ratings.append(rating)
            }
            completion(ratings)
        }
    }
    
    func getListOfObject(path: String, completion: @escaping ObjectsCompletionHandler) {
    }
   
    
    func getSingleObject(path: String){
    }
    
}
