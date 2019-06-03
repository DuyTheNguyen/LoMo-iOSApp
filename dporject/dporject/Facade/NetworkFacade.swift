//
//  DataStorageFacade.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 3/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class NetworkFacade{
   
    private let databaseNetworkController = DatabaseNetworkController()
    
    weak var delegate: NetworkFacadeDelegate?
    
    init(){
        databaseNetworkController.delegate = self
    }
    
    //Database
    func addToMovie(movieId: String, object: Any){
        let result = databaseNetworkController.addToMovie(movieId: movieId, object: object)
        self.delegate?.isAdded(isIt: result)
    }
}

//Create extension to confrom delegate
//DatabaseNetworkController
extension NetworkFacade: DatabaseNetworkControllerDelegate{
    
}
