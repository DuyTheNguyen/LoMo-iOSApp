//
//  DatabaseNetworkController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseNetworkController{
    
    private var rootReference: DatabaseReference!
    
    weak var delegate: DatabaseNetworkControllerDelegate?
    
    init(){
        rootReference = Database.database().reference()
    }
    
    
    func getDictionaryWith(path:String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        
        
        
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let values = snapshot.value as? [String:AnyObject] {
                var movies = [Movie]()
                for (_,value) in values{
                    let movie = Movie(id: value["id"] as? String,
                                      name: value["name"] as? String,
                                      rating: value["rating"] as? String,
                                      year: value["year"] as? String,
                                      image: value["image"] as? String,
                                      genre: value["description"] as? String,
                                      description: value["genre"] as? String,
                                      director: value["director"] as? String)
                    movies.append(movie)
                }
                self.delegate?.didReceivedDictionaryOfMovies(movies: movies)
            }else{
                print("Cannot get values")
            }
            
            
            
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}