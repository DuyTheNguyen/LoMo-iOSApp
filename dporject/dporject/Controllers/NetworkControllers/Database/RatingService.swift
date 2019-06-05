//
//  RatingService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class RatingService:BaseDatabaseNetworkController, ServiceFactory{
  
    
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
    
    func getListOfObject(path: String, completion: @escaping ([Any]) -> ()) {
    }
   
    
    func getSingleObject(path: String){
       
    }
    
}
