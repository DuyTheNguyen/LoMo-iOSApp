//
//  SignUpViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 24/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
   
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    private let userNetworkController = UserNetworkController()
    
    private var isSuccessful: Bool!
    private var alertType: AlertType!
    private var message = String(){
        didSet{
            self.view.stopIndicatorAnnimation()
            if isSuccessful {
                //add alert
                self.signInButtonOnTapped(nil)
            } else{
                alertType = AlertType.FALIED
                performSegue(withIdentifier: "signUpToAlertModal", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        userNetworkController.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func signInButtonOnTapped(_ sender: Any?) {
        //Destroy View before go to the other
        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "signUpToSignIn", sender: nil)
    }
    @IBAction func createButtonOnTapped(_ sender: Any) {
        //Clear error
       
        self.view.startIndicatorAnnimation()
        
        guard  let email = emailText.text, let password = passwordText.text, let cPassword = confirmPasswordText.text else{
            print("Email, password and confirm password label are nil")
            return
        }
        
        
        //Start: Validation
        guard password != "", email != "", cPassword != "" else{
            isSuccessful = false
            message = "Email, Password and Confirm Password could not be empty!"
            return
        }
        
        guard email.isValidEmail() else {
            isSuccessful = false
            message = "Please enter a valid email!"
            return
        }
        
        guard password == cPassword else{
            isSuccessful = false
            message = "Password and Confirm Password must be the same!"
            return
        }
        //End: Validation
       
        
        //Perform connection with database
        userNetworkController.userServiceWith(type: UserService.SIGN_UP, email: email, password: password)
   
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let alertViewController = segue.destination as? AlertViewController{
            alertViewController.bind(alertType: alertType, content: message)
        }
    }
    

}

//Create extension to comform delegate
extension SignUpViewController: UserNetworkControllerDelegate{
    func updateData(isUpdated: Bool, message: String) {
        self.isSuccessful = isUpdated
        self.message = message
    }
}
