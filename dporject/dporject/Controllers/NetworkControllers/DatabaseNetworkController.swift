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
    
    
    func getListOfObjectsFrom(path:String, withDataType: String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        
        //Get the list of movies
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let values = snapshot.value as? [String:AnyObject] {
                switch withDataType {
                case "Movie":
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
                    self.delegate?.didReceivedListOfMovies(movies: movies)
                case "Genre":
                    var genres = [Genre]()
                    for(_, value) in values{
                        let genre = Genre(name: value["name"] as? String,
                                          image: value["image"] as? String)
                        genres.append(genre)
                    }
                    self.delegate?.didReceivedListOfGenres(genres: genres)
                default:
                    print("Something went wrong in the switch case")
                    print("Path: \(rootReference.child(path))")
                    print("Data type: \(withDataType)")
                }
                
                
            }else{
                print("Cannot get values")
                print("Value exist? : \(snapshot.exists())")
                print("Path: \(rootReference.child(path))")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
