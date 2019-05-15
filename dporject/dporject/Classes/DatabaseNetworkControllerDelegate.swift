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
    func isCommentAdded(isIt: Bool)
}

//Make methods for this delegate be optional

extension DatabaseNetworkControllerDelegate{
    func didReceivedListOfMovies(movies: [Movie]){
        
    }
    
    func didReceivedListOfGenres(genres: [Genre]){
        
    }
    
    func isCommentAdded(isIt: Bool){
        
    }

}
