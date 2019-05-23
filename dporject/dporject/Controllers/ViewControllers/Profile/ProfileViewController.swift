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
    
    private var isUpdated:Bool!
    private var alertType: AlertType!
    private var message = String(){
        didSet{
            self.uIImagePickerController.view.stopIndicatorAnnimation()
            self.uIImagePickerController.dismiss(animated: true, completion: nil)
            
            if isUpdated{
                alertType = AlertType.SUCCESS
                performSegue(withIdentifier: "profileToAlert", sender: nil)
            }
            else{
                alertType = AlertType.FALIED
                performSegue(withIdentifier: "profileToAlert", sender: nil)
            }
        }
    }
    
    private let userNetworkController = UserNetworkController()
    private let dataStorageNetworkController = DataStorageNetworkController()
    private let uIImagePickerController = UIImagePickerController()
   
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
              
                avatarImageView.load(urlString: photo)
                avatarImageView.setRounded()
                
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
    @IBOutlet weak var avatarImageView: CustomUIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.tag = ViewTags.PROFILE_VIEW
        
        userNetworkController.delegate = self
        dataStorageNetworkController.delegate = self
        
        uIImagePickerController.delegate = self
        uIImagePickerController.allowsEditing = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNetworkController.authenticationListener()
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
        
        if let alertModalViewController = segue.destination as? AlertViewController{
            alertModalViewController.bind(alertType: alertType, content: message)
        }
    }
 
   
    
    @IBAction func passwordButtonOnTapped(_ sender: Any) {
        performSequeToUpdateWith(type: "password")
    }
    
    @IBAction func emailButtonOnTapped(_ sender: Any) {
        performSequeToUpdateWith(type: "email")
    }
    
    @IBAction func displayNameButtonOnTapped(_ sender: Any) {
       performSequeToUpdateWith(type: "name")
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
         userNetworkController.userServiceWith(type: UserService.SIGN_OUT, email: "", password: "")
         handleControllerTransitionWith(identifier: "SignInViewController")
    }
    
    private func performSequeToUpdateWith(type: String){
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


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func changeImageButtonOnTapped(_ sender: Any) {
        //performSegue(withIdentifier: "profileToAlert", sender: nil)
       
        present(uIImagePickerController, animated: true, completion: nil)
    }
    
    //Get the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.uIImagePickerController.view.startIndicatorAnnimation()
        var selectedImageFromPicker: UIImage?
        
        guard let originalImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        selectedImageFromPicker = originalImage
        
        if let editedImage  = info[.editedImage] as? UIImage{
            selectedImageFromPicker = editedImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            
            //Handle uploading
            dataStorageNetworkController.uploadFile(folderName: "users/\(currrentUser.uid!)", type: "image/png", file: selectedImage, fileName: "avatar")
            
        }
        
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        if let profileView = view.viewWithTag(ViewTags.PROFILE_VIEW){
            profileView.stopIndicatorAnnimation()
        }
    }
}

extension ProfileViewController: DataStorageNetworkControllerDelegate{
    func didUpload(isUpdated: Bool, message: String){
        self.isUpdated = isUpdated
        self.message = message
    }
}
