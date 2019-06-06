//
//  CinemaService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 5/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class CinemaFactory: BaseFactory, FactoryProtocol{
    func add(path: String, object: Any) -> Bool {
        //Not yet
        return false
    }
    
    func delete(path: String) {
        //Not yet
    }
    
    func observe(path: String, completion: @escaping ([Any]) -> ()) {
        //Not yet
    }
    
    func getListOfObject(path: String, completion: @escaping ([Any]) -> ()) {
       
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if let values = snapshot.value as? [String:AnyObject] {
                var cinemas = [Cinema]()
                for(_, value) in values{
                    let cinema = Cinema(snapshot: value)
                    cinemas.append(cinema)
                }
                completion(cinemas)
            }else{
                print("Cannot get values")
                print("Value exist? : \(snapshot.exists())")
                print("Path: \(self.rootReference.child(path))")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getSingleObject(path: String) {
        //Not yet
        
    }
    
    
}
