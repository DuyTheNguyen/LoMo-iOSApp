//
//  UserAuthenticationControllerDelegate.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 2/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation

protocol UserNetworkControllerDelegate: class {
    func didReceiveUser(user: User)
    
    func updateData(isUpdated: Bool, message: String)
    
}

//Make methods of this delegate to be optional
extension UserNetworkControllerDelegate{
    func didReceiveUser(user: User){
        
    }
    
    func updateData(isUpdated: Bool, message: String){
        
    }
    
    
}
