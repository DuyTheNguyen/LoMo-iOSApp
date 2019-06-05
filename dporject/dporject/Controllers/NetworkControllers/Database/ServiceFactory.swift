//
//  ServiceFactory.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 4/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    func add(path: String, object:Any)->Bool
    func delete(path:String)
    
    func getListOfObject(path: String, completion:@escaping ([Any])->())

    func getSingleObject(path:String)
}
