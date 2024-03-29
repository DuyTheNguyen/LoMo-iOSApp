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
    
    private let networkFacade = NetworkServiceFacade()
    
    private var isSuccessful: Bool!
    private var alertType: AlertType!
    private var message = String(){
        didSet{
            self.view.stopIndicatorAnnimation()
            if isSuccessful {
                //add alert
                alertType = AlertType.SUCCESS
                performSegue(withIdentifier: Identifiers.SIGNUP_TO_ALERTMODAL, sender: nil)
                
            } else{
                alertType = AlertType.FALIED
                performSegue(withIdentifier: Identifiers.SIGNUP_TO_ALERTMODAL, sender: nil)
            }
        }
    }
    @objc func goToSignIn(){
       self.signInButtonOnTapped(nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //Using notification for success case
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToSignIn), name: NSNotification.Name(rawValue: Notifications.TO_SIGN_IN), object: nil)
        
        networkFacade.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func signInButtonOnTapped(_ sender: Any?) {
        //Destroy View before go to the other
        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: Identifiers.SIGNUP_TO_SIGNIN, sender: nil)
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
            message = AlertMessages.FAILED_EMPTY_ENAIL_PASSWORD_CPASSWORD
            return
        }
        
        guard email.isValidEmail() else {
            isSuccessful = false
            message = AlertMessages.FAILED_INVALID_EMAIL
            return
        }
        
        guard password == cPassword else{
            isSuccessful = false
            message = AlertMessages.FAILED_DIFFERENT_PASSWORD_CPASSWORD
            return
        }
        //End: Validation
       
        
        //Perform connection with database
        networkFacade.signUp(email: email, password: password)
   
        
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
extension SignUpViewController: NetworkServiceFacadeDelegate{
    func isUpdated(isSuccessful: Bool, message: String) {
        self.isSuccessful = isSuccessful
        self.message = message
    }
}
