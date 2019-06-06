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
    
    private let commentDatabaseService: DatabaseServiceProtocol
    private let ratingDatabaseService: DatabaseServiceProtocol
    private let movieDatabaseService: DatabaseServiceProtocol
    private let cinemaDatabaseService: DatabaseServiceProtocol
    private let genreDatabaseService: DatabaseServiceProtocol

    weak var delegate: NetworkServiceFacadeDelegate?
    
    init(){
        commentDatabaseService = databaseServiceFactory.create(.Comment)
        ratingDatabaseService = databaseServiceFactory.create(.Rating)
        movieDatabaseService = databaseServiceFactory.create(.Movie)
        cinemaDatabaseService = databaseServiceFactory.create(.Cinema)
        genreDatabaseService = databaseServiceFactory.create(.Genre)
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
            self.delegate?.didReceiveUser1(user: user)
        }
    }
    
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
    
    /************************ End: User Service *************************************/
    
    
    
    
    /************************ Begin: Storage *************************************/
    func uploadImage(folderName: String, imageFile: UIImage, fileName: String){
        storageService.uploadImage(folderName: folderName, imageFile: imageFile, fileName: fileName) {
            (isUploaded, message) in
            
            if isUploaded{
                //Update in user service
                let url  = URL.init(string: message)
                self.userService.updatePhoto(value: url!, completion: { (isUpdated, message) in
                     self.delegate?.didUpload1(isUpdated: isUploaded, message: message)
                })
            }else{
                self.delegate?.didUpload1(isUpdated: isUploaded, message: message)
            }
        }
    }
    /************************ End: Storage *************************************/
}

