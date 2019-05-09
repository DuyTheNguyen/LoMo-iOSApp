//
//  UserAuthenticationController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 2/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import FirebaseAuth
class UserAuthenticationNetwrokController{
    weak var delegate: UserAuthenticationNetworkControllerDelegate?
    
    func authenticationListener(){
        Auth.auth().addStateDidChangeListener { (auth, user1) in
            
            guard let user = user1 else{
                //TODO: handle logout
                return
            }
            guard let email = user.email else{
                //TODO: cannot find email
                // add photo URL
                // add display Name
                return
            }
            
            let passedUser = User(pUid: user.uid, pEmail: email, pPassword: "***********")
            
            self.delegate?.didReceiveUser(user: passedUser)
        }
    }
}
