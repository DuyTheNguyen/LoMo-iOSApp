//
//  DatabaseServiceFactory.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 6/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class DatabaseServiceFactory{
    func get(_ serviceType: DatabaseServiceType)->DatabaseService{
        switch(serviceType){
        case .Comment:
            return CommentDatabaseService()
        case .Rating:
            return RatingDatabaseService()
        case .Movie:
            return MovieDatabaseService()
        case .Cinema:
            return CinemaDatabaseService()
        case .Genre:
            return GenreDatabaseService()
        }
    }
}
