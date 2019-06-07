//
//  DataStorageFacade.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 3/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import UIKit

class NetworkServiceFacade{
   
    private let databaseServiceFactory = DatabaseServiceFactory()
    private let userService = UserService()
    private let storageService = StorageService()
    
    private let commentDatabaseService: DatabaseService
    private let ratingDatabaseService: DatabaseService
    private let movieDatabaseService: DatabaseService
    private let cinemaDatabaseService: DatabaseService
    private let genreDatabaseService: DatabaseService

    weak var delegate: NetworkServiceFacadeDelegate?
    
    init(){
        commentDatabaseService = databaseServiceFactory.get(.Comment)
        ratingDatabaseService = databaseServiceFactory.get(.Rating)
        movieDatabaseService = databaseServiceFactory.get(.Movie)
        cinemaDatabaseService = databaseServiceFactory.get(.Cinema)
        genreDatabaseService = databaseServiceFactory.get(.Genre)
    }
   
    /************************ Begin: Database *************************************/
    //////////////Add///////////////
    func addComment(movieId: String, object: Any){
        let result = commentDatabaseService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    func addRating(movieId: String, object: Any){
        let result = ratingDatabaseService.add(path: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
    
    
    /////////////Observe//////////////
    func observeComments(path:String){
        commentDatabaseService.observe(path: path){ comments in
            self.delegate?.watchListOfComments(comments: comments as! [Comment])
        }
        
    }
    func observeRatings(path:String){
        ratingDatabaseService.observe(path: path) { ratings in
            self.delegate?.watchListOfRatings(ratings: ratings as! [Rating])
        }
    }
    
    
    /////////////Remove Observe//////////////
    func removeObserveComments(path:String){
        commentDatabaseService.removeObserveDatabase(path: path)
    }
    
    func removeObserveRating(path:String){
        ratingDatabaseService.removeObserveDatabase(path: path)
    }
    
    
    ////////////Get Objects/////////
    func getListOfMovies(path:String){
        var result = [Any]()
        movieDatabaseService.getListOfObject(path: path){ movies in
            result = movies
            self.delegate?.didReceivedListOfMovies(movies: result as! [Movie])
        }
    }
    
    func getListOfCinemas(path:String){
        cinemaDatabaseService.getListOfObject(path: path) { (cinemas) in
            self.delegate?.didReceivedListOfCinemas(cinemas: cinemas as! [Cinema])
        }
    }
    
    func getListOfGenre(path: String){
        genreDatabaseService.getListOfObject(path: path) { (genres) in
            self.delegate?.didReceivedListOfGenres(genres: genres as! [Genre])
        }
    }
    /************************ End: Database *************************************/
    
    
    
    
    
    /************************ Begin: User Service *************************************/
    func checkCurrentUserStatus(){
        userService.authenticationListener { (user) in
            self.delegate?.didReceiveUser(user: user)
        }
    }
    
    func signIn(email: String, password:String){
        userService.signIn(email: email, password: password) { (isUpdated, message) in
            self.delegate?.isUpdated(isSuccessful: isUpdated, message: message)
        }
    }
    
    func signUp(email: String, password:String){
        userService.signUp(email: email, password: password) { (isUpdated, message) in
            self.delegate?.isUpdated(isSuccessful: isUpdated, message: message)
        }
    }
    
    func signOut(){
        userService.signOut()
    }
    
    func updateEmail(email: String){
        userService.updateEmail(value: email) { (isUpdated, message) in
            self.delegate?.isUpdated(isSuccessful: isUpdated, message: message)
        }
    }
    
    func updatePassword(email: String){
        userService.updatePassword(value: email) { (isUpdated, message) in
            self.delegate?.isUpdated(isSuccessful: isUpdated, message: message)
        }
    }
    
    func updateName(name: String){
        userService.updateName(value: name) { (isUpdated, message) in
            self.delegate?.isUpdated(isSuccessful: isUpdated, message: message)
        }
    }
    
    /************************ End: User Service *************************************/
    
    
    
    
    /************************ Begin: Storage *************************************/
    func uploadImage(folderName: String, imageFile: UIImage, fileName: String){
        storageService.uploadImage(folderName: folderName, imageFile: imageFile, fileName: fileName) {
            (isUploaded, message) in
            
            if isUploaded{
                //Update in user service
                let url  = URL.init(string: message)
                self.userService.updatePhoto(value: url!, completion: { (isUpdated, message) in
                     self.delegate?.isUploaded(isSuccessful: isUploaded, message: message)
                })
            }else{
                self.delegate?.isUploaded(isSuccessful: isUploaded, message: message)
            }
        }
    }
    /************************ End: Storage *************************************/
}

