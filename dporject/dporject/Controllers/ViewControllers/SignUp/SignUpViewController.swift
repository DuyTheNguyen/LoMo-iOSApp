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

    
   
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    private let userNetworkController = UserNetworkController()
    
    private var isSuccessful: Bool!
    private var message = String(){
        didSet{
            self.view.stopIndicatorAnnimation()
            if isSuccessful {
                //add alert
                self.signInButtonOnTapped(nil)
            } else{
                errorLabel.text = message
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        errorLabel.text = ""
        self.view.startIndicatorAnnimation()
        if let email = emailText.text, let password = passwordText.text{
            userNetworkController.userServiceWith(type: UserService.SIGN_UP, email: email, password: password)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//Create extension to comform delegate
extension SignUpViewController: UserNetworkControllerDelegate{
    func updateData(isUpdated: Bool, message: String) {
        self.isSuccessful = isUpdated
        self.message = message
    }
}
