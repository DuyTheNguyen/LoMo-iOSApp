//
//  NetworkFacadeDelegate.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 3/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation


protocol NetworkFacadeDelegate: class{
     func didReceivedListOfMovies(movies : [Movie])
     func didReceivedListOfGenres(genres: [Genre])
     func didReceivedListOfCinemas(cinemas: [Cinema])
     func watchListOfComments(comments: [Comment])
     func watchListOfRatings( ratings: [Rating])
     func isAdded(isIt: Bool)
    
}

//Make methods of this delegate to be optional

extension NetworkFacadeDelegate{
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
    
    func isAdded(isIt: Bool){
        
    }
    
}
