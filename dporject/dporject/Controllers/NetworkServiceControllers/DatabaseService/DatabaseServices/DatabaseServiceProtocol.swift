//
//  ServiceFactory.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

protocol DatabaseServiceProtocol {
    typealias  ObjectsCompletionHandler = (_ objects:[Any]) -> ()
    
    func add(path: String, object:Any)->Bool
    func delete(path:String)
    func observe(path:String, completion: @escaping ObjectsCompletionHandler)
    
    func getListOfObject(path: String, completion:@escaping ObjectsCompletionHandler)

    func getSingleObject(path:String)
}
