//
//  MovieService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class MovieService: BaseDatabaseNetworkController, ServiceFactory{
    func add(path: String, object: Any) -> Bool {
        return false
    }
    
    func delete(path: String) {
        
    }
    
    func getListOfObject(path: String) -> [Any] {
        //Get the list of object
        var movies = [Movie]()
     // self.dispatchGroup.enter()
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
           
            if let values = snapshot.value as? [String:AnyObject] {
                
               
                    for (_,value) in values{
                        let movie = Movie(snapshot: value)
                        movies.append(movie)
                    }
                    //self.dispatchGroup.leave()
                
               
               //  self.dispatchGroup.wait()
            }else{
                print("Cannot get values")
                print("Value exist? : \(snapshot.exists())")
                print("Path: \(self.rootReference.child(path))")
            }
            //self.dispatchGroup.leave()
        }) { (error) in
            print(error.localizedDescription)
             self.dispatchGroup.leave()
        }
        
        
        return movies
    }
    
    func getSingleObject(path: String){
        
    }
    
    
}
