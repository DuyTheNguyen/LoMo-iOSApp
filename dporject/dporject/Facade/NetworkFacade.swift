//
//  DataStorageFacade.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 3/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class NetworkFacade{
   
    private let baseDatabaseNetworkControlle = BaseService()
    private let commentService = CommentService()
    private let ratingService = RatingService()
    private let movieService = MovieService()
    private let cinemaService = CinemaService()
    private let genreService = GenreService()
    
    weak var delegate: NetworkFacadeDelegate?
    
   
    /************************ Begin: Database *************************************/
    //////////////Add///////////////
    func addComment(movieId: String, object: Any){
        let result = commentService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    func addRating(movieId: String, object: Any){
        let result = ratingService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    
    /////////////Observe//////////////
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
    
    
    /////////////Remove Observe//////////////
    func removeObserve(path:String){
        baseDatabaseNetworkControlle.removeObserveDatabase(path: path)
    }
    
   
    
    
    ////////////Get Objects/////////
    func getListOfMovies(path:String){
        var result = [Any]()
        movieService.getListOfObject(path: path){ movies in
            result = movies
            self.delegate?.didReceivedListOfMovies(movies: result as! [Movie])
        }
    }
    
    func getListOfCinemas(path:String){
        cinemaService.getListOfObject(path: path) { (cinemas) in
            self.delegate?.didReceivedListOfCinemas(cinemas: cinemas as! [Cinema])
        }
    }
    
    func getListOfGenre(path: String){
        genreService.getListOfObject(path: path) { (genres) in
            self.delegate?.didReceivedListOfGenres(genres: genres as! [Genre])
        }
    }
    /************************ End: Database *************************************/
}

