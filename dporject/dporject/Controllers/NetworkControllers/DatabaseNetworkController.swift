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
    
    private let rootReference: DatabaseReference?
    
    weak var delegate: DatabaseNetworkControllerDelegate?
    
    init(){
        rootReference = Database.database().reference()
    }
    
    
    //Add 
    func addToMovie(movieId: String, object: Any)-> Bool{
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            self.delegate?.isCommentAdded1(isIt: false)
            return false
        }
        
        if object is Comment{
            
            let comment = object as! Comment
            let commentRef = rootReference.child("\(Paths.COMMENTS)/\(movieId)").childByAutoId()
            commentRef.setValue([
                "commentId" : commentRef.key,
                "userId": comment.userId,
                "userName": comment.userName,
                "image" : comment.image,
                "timestamp" : comment.timestamp,
                "content": comment.content
                ])
            return true
            
        }else if object is Rating{
            let rating = object as! Rating
            let ratingRef = rootReference.child("\(Paths.RATING)").child(movieId).child(rating.userId!)
            ratingRef.setValue([
                "userId": rating.userId!,
                "value": rating.value!
                ])
            
            return true
        }else{
            fatalError("Not a proper type")
        }
    }
    
    
    //Observe the data in the database
    func observeDatabase(type: ObserveType, path:String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        rootReference.child(path).observe(.value) { (snapshot) in
            guard let values = snapshot.value as? [String:AnyObject] else {
                print("Could not load list of objects or empty list")
                return
            }
            switch type{
            case .COMMENT:
                var comments = [Comment]()
                for (_,value) in values{
                    let comment = Comment(snapshot: value)
                    comments.append(comment)
                }
                self.delegate?.watchListOfComments(comments: comments)
            case .RATING:
                var ratings = [Rating]()
                for(_,value) in values{
                    let rating = Rating(snapshot: value)
                    ratings.append(rating)
                }
                self.delegate?.watchListOfRatings(ratings: ratings)
            }
        }
    }
    
    //Remove observation
    func removeObserveDatabase(path: String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        rootReference.removeAllObservers()
    }
    
    //Get genres, movies and comment
    func getListOfObjectsFrom(path:String, withDataType: DataType){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        
        //Get the list of object
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if let values = snapshot.value as? [String:AnyObject] {
                //Begin: Switch
                switch withDataType {
                    case .Movie:
                        var movies = [Movie]()
                        
                        for (_,value) in values{
                            let movie = Movie(snapshot: value)
                            movies.append(movie)
                        }
                        self.delegate?.didReceivedListOfMovies(movies: movies)
                    
                    case .Genre:
                        var genres = [Genre]()
                        for(_, value) in values{
                            let genre = Genre(snapshot: value)
                            genres.append(genre)
                        }
                        self.delegate?.didReceivedListOfGenres(genres: genres)
                    
                    case .Cinema:
                      
                        var cinemas = [Cinema]()
                        for(_, value) in values{
                            let cinema = Cinema(snapshot: value)
                            cinemas.append(cinema)
                        }
                        self.delegate?.didReceivedListOfCinemas(cinemas: cinemas)
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
