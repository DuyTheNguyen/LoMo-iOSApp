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
    
   
    
    
    func addComment(movieId: String, object: Any){
        let result = commentService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    func observeComments(path:String){
        let result = commentService.observe(path: path)
        self.delegate?.watchListOfComments(comments: result)
    }
    
    func addRating(movieId: String, object: Any){
        let result = ratingService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    
    
    //Get Objects
    func getListOfMovies(path:String){
        let result = movieService.getListOfObject(path: path) as! [Movie]
        self.delegate?.didReceivedListOfMovies(movies: result)
    }
    
}

//Create extension to confrom delegate
//DatabaseNetworkController
extension NetworkFacade: ObservationDelegate{
    func watchObjects(object: Any) {
        
    }
}
