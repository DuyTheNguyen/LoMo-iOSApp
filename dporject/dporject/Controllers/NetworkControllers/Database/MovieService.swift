//
//  MovieService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class MovieService: BaseDatabaseNetworkController{
    func add(path: String, object: Any) -> Bool {
        return false
    }
    
    func delete(path: String) {
        
    }
    
    func getListOfObject(path: String, completion:@escaping ([Any])->()){
        //Get the list of object
        var movies = [Movie]()
    
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
           
            if let values = snapshot.value as? [String:AnyObject] {
                
               
                    for (_,value) in values{
                        let movie = Movie(snapshot: value)
                        movies.append(movie)
                    }
                
                    completion(movies)
               
              
            }else{
                print("Cannot get values")
                print("Value exist? : \(snapshot.exists())")
                print("Path: \(self.rootReference.child(path))")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getSingleObject(path: String){
        
    }
    
    
}
