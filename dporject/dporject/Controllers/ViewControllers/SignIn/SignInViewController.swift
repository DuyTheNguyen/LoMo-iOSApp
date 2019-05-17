//
//  ViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 14/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
class SignInViewController: UIViewController {
    
    
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
   
    private let userNetworlController = UserNetworkController()
    
    private var isSuccessful: Bool!
    private var message = String(){
        didSet{
            view.stopIndicatorAnnimation()
            if isSuccessful{
                
                //add alert
                self.handleControllerTransitionWith(identifier: "TabBarController")
            }else{
                errorLabel.text = message
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //Destroy View before go to the other
        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "signInToSignUp", sender: nil)
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        errorLabel.text = ""
        if let email = emailText.text, let password = passwordText.text{
            userNetworlController.signInWith(email: email, password: password)
            self.view.startIndicatorAnnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNetworlController.delegate = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailText.text = "dave@gmail.com"
        passwordText.text = "dave123"
        errorLabel.text = ""
    }
}

//Create extension to conform delegate
extension SignInViewController: UserNetworkControllerDelegate{
    func updateData(isUpdated: Bool, message: String) {
        self.isSuccessful = isUpdated
        self.message = message
    }
}

