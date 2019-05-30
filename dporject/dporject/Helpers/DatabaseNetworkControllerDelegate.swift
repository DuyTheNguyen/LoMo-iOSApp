//
//  DatabaseNetworkControllerDelegate.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
protocol DatabaseNetworkControllerDelegate: class{
    func didReceivedListOfMovies(movies : [Movie])
    func didReceivedListOfGenres(genres: [Genre])
    func didReceivedListOfCinemas(cinemas: [Cinema])
    func watchListOfComments(comments: [Comment])
    func watchListOfRatings( ratings: [Rating])
    func isCommentAdded(isIt: Bool)
    func isRatingAdded(isIt: Bool)
}

//Make methods of this delegate to be optional

extension DatabaseNetworkControllerDelegate{
    func didReceivedListOfMovies(movies: [Movie]){
        
    }
    
    func didReceivedListOfGenres(genres: [Genre]){
        
    }
    
    func didReceivedListOfCinemas(cinemas: [Cinema]){
        
    }
    
    func watchListOfComments(comments: [Comment]){
        
    }
    
    func watchListOfRatings( ratings: [Rating]){
        
    }
    
    func isCommentAdded(isIt: Bool){
        
    }
    
    func isRatingAdded(isIt: Bool){
        
    }

}
