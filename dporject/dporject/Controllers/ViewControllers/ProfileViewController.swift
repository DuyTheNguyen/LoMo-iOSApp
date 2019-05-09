//
//  ProfileViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 24/4/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    private let userAuthenticationController = UserAuthenticationNetwrokController()
    
    fileprivate var user = User(){
        didSet{
            emailLabel.text = user.email
            userIdLabel.text = user.uid
        }
    }
        
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userAuthenticationController.delegate = self
        userAuthenticationController.authenticationListener()
        
        print(Auth.auth().currentUser?.email ?? "NOOOO")
        print(Auth.auth().currentUser?.uid ?? "NOOO")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signOutButtonTapped(_ sender: Any) {
         handleControllerTransitionWith(identifier: "SignInViewController")
    }
    
    
    
}

//Create extension to conform Delegate
extension ProfileViewController: UserAuthenticationNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        self.user = user
    }
    
}
