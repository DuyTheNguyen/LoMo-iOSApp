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
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                //If it has error
                guard error == nil else{
                    self.errorLabel.text = error?.localizedDescription
                    return
                }
                
                self.signInButtonOnTapped(nil)
                print(user?.user.email ?? "1")
                print(user?.user.uid ?? "2")
                print(Auth.auth().currentUser?.uid ?? "3")
            }
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
