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
    func userServiceWith(type: UserService, email: String, password: String){
        switch type{
        case .SIGN_IN:
            authentication.signIn(withEmail: email, password: password) { (user, error) in
                self.callBack(error: error, successfulMessage: "Sign In Successfully")
            }
        case .SIGN_UP:
            authentication.createUser(withEmail: email, password: password) { (user, error) in
                self.callBack(error: error, successfulMessage: "Sign Up Successfully")
            }
        case .SIGN_OUT:
            do{
               try authentication.signOut()
            } catch let signOutError as NSError{
               print ("Error signing out: %@", signOutError)
            }
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
                self.callBack(error: error, successfulMessage: "Updated Successfully")
            }
        case "password":
            currentUser.updatePassword(to: withValue) { (error) in
                self.callBack(error: error, successfulMessage: "Updated Successfully")
            }
        case "name":
            let changeRequest = currentUser.createProfileChangeRequest()
            changeRequest.displayName = withValue
            changeRequest.commitChanges { (error) in
                 self.callBack(error: error, successfulMessage: "Updated Successfully")
            }
        default:
            print("Should not in default")
        }
    }
    
    private func callBack(error: Error!, successfulMessage: String){
        if let error = error{
            print(error.localizedDescription)
            self.delegate?.updateData(isUpdated: false, message: error.localizedDescription)
        }else{
            self.delegate?.updateData(isUpdated: true, message: successfulMessage)
        }
    }
}
