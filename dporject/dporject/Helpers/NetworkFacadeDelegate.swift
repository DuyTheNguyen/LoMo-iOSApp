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
    
     func didReceiveUser1(user: User)
     func updateData1(isUpdated: Bool, message: String)
    
     func didUpload1(isUpdated: Bool, message: String)
}

//Make methods of this delegate to be optional

extension NetworkFacadeDelegate{
    func didReceivedListOfMovies(movies: [Movie]){}
    func didReceivedListOfGenres(genres: [Genre]){}
    func didReceivedListOfCinemas(cinemas: [Cinema]){}
    func watchListOfComments(comments: [Comment]){}
    func watchListOfRatings( ratings: [Rating]){}
    func isAdded(isIt: Bool){}
    
    func didReceiveUser1(user: User){}
    func updateData1(isUpdated: Bool, message: String){}
    func didUpload1(isUpdated: Bool, message: String){}
}
