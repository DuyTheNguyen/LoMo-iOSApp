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
    
    
   
    private let userNetworlController = UserNetworkController()
    
    private var isSuccessful: Bool!
    private var alertType: AlertType!
    private var message = String(){
        didSet{
            view.stopIndicatorAnnimation()
            guard isSuccessful != nil else{
                performSegue(withIdentifier: "signInToAlertModal", sender: nil)
                return
            }
            
            if isSuccessful{
                //add alert
                self.handleControllerTransitionWith(identifier: "TabBarController")
            }else{                alertType = AlertType.FALIED
                performSegue(withIdentifier: "signInToAlertModal", sender: nil)
            }
        }
    }
    @IBAction func forgotButtonOnTapped(_ sender: Any) {
        alertType = AlertType.INFO
        message = AlertMessages.INFO_NOT_IMPLEMENTED
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //Destroy View before go to the other
        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "signInToSignUp", sender: nil)
        
       
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let  email = emailText.text, let password = passwordText.text else{
            print("Email and Password text are nil")
            return
        }
        
        guard email != "", password != "" else{
            isSuccessful = false
            message = AlertMessages.FAILED_EMPTY_EMAIL_PASSWORD
            return
        }
        
        guard email.isValidEmail() else {
            isSuccessful =  false
            message = AlertMessages.FAILED_EMPTY_STRING
            return
        }
        
      
        userNetworlController.userServiceWith(type: UserService.SIGN_IN, email: email, password: password)
        self.view.startIndicatorAnnimation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        userNetworlController.delegate = self
        
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailText.text = "dave@gmail.com"
        passwordText.text = "dave123"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alertModalController  = segue.destination as? AlertViewController{
            alertModalController.bind(alertType: alertType, content: message)
        }
    }
}

//Create extension to conform delegate
extension SignInViewController: UserNetworkControllerDelegate{
    func updateData(isUpdated: Bool, message: String) {
        self.isSuccessful = isUpdated
        self.message = message
    }
}


