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
    
    //Add comments
    func addComment(movieId: String, comment: Comment){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            self.delegate?.isCommentAdded(isIt: false)
            return
        }
        
        let commentRef = rootReference.child("comments/\(movieId)").childByAutoId()
        commentRef.setValue([
            "commentId" : commentRef.key,
            "userId": comment.userId,
            "userName": comment.userName,
            "image" : comment.image,
            "timestamp" : comment.timestamp,
            "content": comment.content
        ])
        
        self.delegate?.isCommentAdded(isIt: true)
       
    }
    
    //Observe the data in the database
    func observeDatabase(path:String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        rootReference.child(path).observe(.value) { (snapshot) in
            guard let values = snapshot.value as? [String:AnyObject] else {
                fatalError("Could not load list of comments")
            }
            var comments = [Comment]()
            for (_,value) in values{
                let comment = Comment(snapshot: value)
                comments.append(comment)
            }
            
        }
    }
    
    //Remove all observation
    func removeObserveDatabase(path: String){
        
    }
    
    //Get genres, movies and comment
    func getListOfObjectsFrom(path:String, withDataType: String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        
        //Get the list of object
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if let values = snapshot.value as? [String:AnyObject] {
                //Begin: Switch
                switch withDataType {
                    case "Movie":
                        var movies = [Movie]()
                        
                        for (_,value) in values{
                            let movie = Movie(id: value["id"] as? String,
                                              name: value["name"] as? String,
                                              rating: value["rating"] as? String,
                                              year: value["year"] as? String,
                                              image: value["image"] as? String,
                                              genre: value["genre"] as? String,
                                              description: value["description"] as? String,
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
                //End: Switch

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
