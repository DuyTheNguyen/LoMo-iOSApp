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
    let authentication = Auth.auth()
    
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
    
    func update(){
        
    }
}
