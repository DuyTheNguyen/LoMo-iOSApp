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

    private let userAuthenticationController = UserNetworkController()
    private var type: String? = ""
    
    fileprivate var currrentUser = User(){
        didSet{
            emailLabel.text = currrentUser.email
            passwordLabel.text = currrentUser.password
            
            if let name = currrentUser.displayName{
                nameLabel.text = name
                displayNameLabel.text = name
            }else{
                nameLabel.text = "No Name"
                displayNameLabel.text = "No Name"
            }
            
            if let photo = currrentUser.photoURL {
                avatarImageView.load(imageString: photo)
            }else{
                avatarImageView.image = Icons.USER_MALE
            }
        }
    }
        
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userAuthenticationController.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userAuthenticationController.authenticationListener()
        signOutButton.buttonWithText(title: "Sign Out", iconName: Icons.SIGN_OUT)
        signOutButton.layer.cornerRadius = 15
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let updateModalViewControler = segue.destination as? UpdateModalViewController{
            updateModalViewControler.bind(type: type!)
        }
    }
 
    @IBAction func changeImageButtonOnTapped(_ sender: Any) {
    }
    
    @IBAction func passwordButtonOnTapped(_ sender: Any) {
        performSequeWithString(type: "password")
    }
    
    @IBAction func emailButtonOnTapped(_ sender: Any) {
        performSequeWithString(type: "email")
    }
    
    @IBAction func displayNameButtonOnTapped(_ sender: Any) {
       performSequeWithString(type: "name")
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
         handleControllerTransitionWith(identifier: "SignInViewController")
    }
    
    private func performSequeWithString(type: String){
        self.type = type
        performSegue(withIdentifier: "profileToUpdate", sender: nil)
    }
}

//Create extension to conform Delegate
extension ProfileViewController: UserNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        self.currrentUser = user
    }
    
}
