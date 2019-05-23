//
//  DataStorageNetworkControllerDelegate.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 23/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

protocol DataStorageNetworkControllerDelegate: class {
    func didUpload()
}

//Make methods of this delegate to be optional

extension DataStorageNetworkControllerDelegate{
    func didUpload(){
        
    }
}
