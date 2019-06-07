//
//  UserService.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 5/6/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserService{
    typealias  CompletionHandler = (_ success:Bool,_ message:String) -> ()
    private let authentication = Auth.auth()
    private let currentUser = Auth.auth().currentUser
    
    func authenticationListener(completion: @escaping (User) -> ()){
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
            
            completion(passedUser)
        }
    }
    
    func signIn(email: String, password:String, completion: @escaping CompletionHandler){
        authentication.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false,error.localizedDescription)
            }else{
                completion(true, AlertMessages.SUCCESS_SIGNIN)
            }
        }
    }
    
    func signUp(email: String, password:String, completion: @escaping CompletionHandler){
        authentication.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false,error.localizedDescription)
            }else{
                completion(true, AlertMessages.SUCCESS_SIGNUP)
            }
        }
    }
    
    func signOut(){
        do{
            try authentication.signOut()
        } catch let signOutError as NSError{
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func updateEmail(value: String, completion: @escaping CompletionHandler){
        currentUser?.updateEmail(to: value, completion: { (error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            }else{
                completion(true, AlertMessages.SUCCESS_UPDATE_EMAIL)
            }
        })
    }
    
    func updatePassword(value: String, completion: @escaping CompletionHandler){
        currentUser?.updatePassword(to: value, completion: { (error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            }else{
                completion(true, AlertMessages.SUCCESS_UPDATE_PASSWORD)
            }
        })
    }
    
    func updateName(value: String, completion: @escaping CompletionHandler){
        let changeRequest = currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = value
        changeRequest?.commitChanges { (error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            }else{
                completion(true, AlertMessages.SUCCESS_UPDATE_NAME)
            }
        }
    }
    
    func updatePhoto(value: URL, completion: @escaping CompletionHandler){
        let changeRequest = currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = value
        changeRequest?.commitChanges { (error) in
            if let error = error{
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            }else{
                completion(true, AlertMessages.SUCCESS_UPDATE_IMAGE)
            }
        }
    }
}
