//
//  DataStorageFacade.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 3/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class NetworkFacade{
   
    private let commentService = CommentService()
    private let ratingService = RatingService()
    private let movieService = MovieService()
    
    weak var delegate: NetworkFacadeDelegate?
    
    
    init(){
        commentService.delegate = self
    }
    
   
    /************************ Begin: Database *************************************/
    //Add
    func addComment(movieId: String, object: Any){
        let result = commentService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
  
    
    func addRating(movieId: String, object: Any){
        let result = ratingService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    
    //Observe
    func observeComments(path:String){
        commentService.observe(path: path){ comments in
            self.delegate?.watchListOfComments(comments: comments as! [Comment])
        }
        
    }
    
    func observeRatings(path:String){
        ratingService.observe(path: path) { ratings in
            self.delegate?.watchListOfRatings(ratings: ratings as! [Rating])
        }
    }
    
    //Get Objects
    func getListOfMovies(path:String){
        var result = [Any]()
        movieService.getListOfObject(path: path){ movies in
            result = movies
            self.delegate?.didReceivedListOfMovies(movies: result as! [Movie])
        }
    }
    
    /************************ End: Database *************************************/
}

//Create extension to confrom delegate
//DatabaseNetworkController
extension NetworkFacade: ObservationDelegate{
    func watchObjects(object: Any) {
        
    }
}
