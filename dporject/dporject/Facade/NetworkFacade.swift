//
//  DataStorageFacade.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 3/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class NetworkFacade{
   
    private let baseFactory = BaseFactory()
    private let commentFactory = CommentFactory()
    private let ratingFactory = RatingFactory()
    private let movieFactory = MovieFactory()
    private let cinemaFactory = CinemaFactory()
    private let genreFactory = GenreFactory()
    
    private let userService = UserService()

    weak var delegate: NetworkFacadeDelegate?
    
   
    /************************ Begin: Database *************************************/
    //////////////Add///////////////
    func addComment(movieId: String, object: Any){
        let result = commentFactory.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    func addRating(movieId: String, object: Any){
        let result = ratingFactory.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    
    /////////////Observe//////////////
    func observeComments(path:String){
        commentFactory.observe(path: path){ comments in
            self.delegate?.watchListOfComments(comments: comments as! [Comment])
        }
        
    }
    func observeRatings(path:String){
        ratingFactory.observe(path: path) { ratings in
            self.delegate?.watchListOfRatings(ratings: ratings as! [Rating])
        }
    }
    
    
    /////////////Remove Observe//////////////
    func removeObserve(path:String){
        baseFactory.removeObserveDatabase(path: path)
    }
    
    
    ////////////Get Objects/////////
    func getListOfMovies(path:String){
        var result = [Any]()
        movieFactory.getListOfObject(path: path){ movies in
            result = movies
            self.delegate?.didReceivedListOfMovies(movies: result as! [Movie])
        }
    }
    
    func getListOfCinemas(path:String){
        cinemaFactory.getListOfObject(path: path) { (cinemas) in
            self.delegate?.didReceivedListOfCinemas(cinemas: cinemas as! [Cinema])
        }
    }
    
    func getListOfGenre(path: String){
        genreFactory.getListOfObject(path: path) { (genres) in
            self.delegate?.didReceivedListOfGenres(genres: genres as! [Genre])
        }
    }
    /************************ End: Database *************************************/
    
    /************************ Begin: User Service *************************************/
    func signIn(email: String, password:String){
        userService.signIn(email: email, password: password) { (isUpdated, message) in
            self.delegate?.updateData1(isUpdated: isUpdated, message: message)
        }
    }
    
    func signUp(email: String, password:String){
        userService.signUp(email: email, password: password) { (isUpdated, message) in
            self.delegate?.updateData1(isUpdated: isUpdated, message: message)
        }
    }
    
    func signOut(){
        userService.signOut()
    }
    
    func updateEmail(email: String){
        userService.updateEmail(value: email) { (isUpdated, message) in
            self.delegate?.updateData1(isUpdated: isUpdated, message: message)
        }
    }
    
    func updatePassword(email: String){
        userService.updatePassword(value: email) { (isUpdated, message) in
            self.delegate?.updateData1(isUpdated: isUpdated, message: message)
        }
    }
    
    func updateName(name: String){
        userService.updateName(value: name) { (isUpdated, message) in
            self.delegate?.updateData1(isUpdated: isUpdated, message: message)
        }
    }
    
    func updatePhoto(path: String){
        userService.updatePhoto(value: path) { (isUpdated, message) in
            self.delegate?.updateData1(isUpdated: isUpdated, message: message)
        }
    }
    /************************ End: User Service *************************************/
}

