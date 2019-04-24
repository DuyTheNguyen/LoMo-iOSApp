//
//  ViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 14/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var dataRef  : DatabaseReference!
    var emailRef: DatabaseReference!
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //Destroy View before go to the other
        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "signInToSignUp", sender: nil)
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
          /*emailRef.setValue(emailTextField.text)*/
        errorLabel.text = ""
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                //Handle errors if has
                guard error == nil else{
                    self.errorLabel.text = error?.localizedDescription
                    return
                }
                
                self.handleControllerTransitionWith(identifier: "TabBarController")
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        dataRef = Database.database().reference()
        emailRef = dataRef.child("someid/name")
        
        dataRef.child("someid/name").setValue("hahaha")
        */
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        emailRef.observeSingleEvent(of: .value) { (dataSnapShot) in
            self.emailLabel.text = dataSnapShot.value as? String
        }
         */
    }
    
}

