//
//  UserAuthenticationController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 2/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import FirebaseAuth
class UserNetworkController{
    weak var delegate: UserNetworkControllerDelegate?
    
    private let authentication: Auth!
    
    init() {
        authentication = Auth.auth()
    }
    
    func authenticationListener(){
        authentication.addStateDidChangeListener { (auth, user1) in
            
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
    
    func updateProfile(_ withType : String, withValue: String){
        guard let currentUser = authentication.currentUser else{
            print("Could get current user")
            return
        }
        switch withType {
        case "email":
            print("update email")
            currentUser.updatePassword(to: withValue) { (error) in
                guard error != nil else {
                    print(error?.localizedDescription)
                    self.delegate?.updateProfile(isUpdated: false, message: error?.localizedDescription)
                    return
                }
            }
            
            //sucessfull delegate
            self.delegate?.updateProfile(isUpdated: true)
        default:
            print("Should not in default")
        }
    }
}
