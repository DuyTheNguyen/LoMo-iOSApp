//
//  BaseDatabaseNetworkController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import FirebaseDatabase
class BaseFactory{
    let rootReference = Database.database().reference()
    
    func removeObserveDatabase(path: String){
        rootReference.child(path).removeAllObservers()
    }
}

