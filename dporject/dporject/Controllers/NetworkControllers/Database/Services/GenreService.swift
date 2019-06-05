//
//  GenreService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 5/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

class GenreService: BaseService, ServicesFactory{
    func add(path: String, object: Any) -> Bool {
        return false
    }
    
    func delete(path: String) {
        
    }
    
    func observe(path: String, completion: @escaping ([Any]) -> ()) {
        
    }
    
    func getListOfObject(path: String, completion: @escaping ([Any]) -> ()) {
        rootReference.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if let values = snapshot.value as? [String:AnyObject] {
                var genres = [Genre]()
                for(_, value) in values{
                    let genre = Genre(snapshot: value)
                    genres.append(genre)
                }
                completion(genres)
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
        
    }
    
    
}
