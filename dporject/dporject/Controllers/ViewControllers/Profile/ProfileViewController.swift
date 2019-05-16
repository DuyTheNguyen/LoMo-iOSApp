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

    private let userAuthenticationController = UserAuthenticationNetworkController()
    
    fileprivate var currrentUser = User(){
        didSet{
            emailLabel.text = currrentUser.email
            userIdLabel.text = currrentUser.uid
            if currrentUser.photoURL != "" {
                avatarImageView.load(imageString: currrentUser.photoURL!)
            }else{
                avatarImageView.image = Icons.USER_MALE
            }
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
        self.currrentUser = user
    }
    
}
