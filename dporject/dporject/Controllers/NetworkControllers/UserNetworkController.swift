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
            
            
            let passedUser = User(pUid: user.uid, pEmail: email, pPassword: "***********", pDisplayName: user.displayName, pPhotoURL: user.photoURL)
            
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
            currentUser.updateEmail(to: withValue) { (error) in
                self.validation(error: error)
            }
        case "password":
            currentUser.updatePassword(to: withValue) { (error) in
                self.validation(error: error)
            }
        case "name":
            let changeRequest = currentUser.createProfileChangeRequest()
            changeRequest.displayName = withValue
            changeRequest.commitChanges { (error) in
                self.validation(error: error)
            }
        default:
            print("Should not in default")
        }
    }
    
    private func validation(error: Error!){
        if let error = error{
            print(error.localizedDescription)
            self.delegate?.updateProfile(isUpdated: false, message: error.localizedDescription)
        }else{
            self.delegate?.updateProfile(isUpdated: true, message: "Updated Successfully")
        }
    }
}
