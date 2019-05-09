//
//  DatabaseNetworkController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseNetworkController{
    
    private var rootReference: DatabaseReference!
    
    init(){
        rootReference = Database.database().reference()
    }
    
    
    func getDictionaryWith(path:String){
        guard let rootReference = rootReference else{
            print("Something went wrong with root reference")
            return
        }
        
        rootReference.child(path).observeSingleEvent(of: .value) { (snapshot) in
            if let val = snapshot.value as? [String: Any]{
                
            }
        }
        
    }
}
