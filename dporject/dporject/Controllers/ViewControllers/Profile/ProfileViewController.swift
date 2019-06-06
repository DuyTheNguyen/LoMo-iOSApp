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
                performSegue(withIdentifier: Identifiers.PROFILE_TO_ALERTMODAL, sender: nil)
            }
            else{
                alertType = AlertType.FALIED
                performSegue(withIdentifier: Identifiers.PROFILE_TO_ALERTMODAL, sender: nil)
            }
        }
    }
    
    private let networkFacade = NetworkFacade()
    private let uIImagePickerController = UIImagePickerController()
   
    private var userServiceType: UserServiceType?
    
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
        
        networkFacade.delegate = self
        
        uIImagePickerController.delegate = self
        uIImagePickerController.allowsEditing = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkFacade.checkCurrentUserStatus()
        signOutButton.buttonWithText(title: "Sign Out", iconName: Icons.SIGN_OUT)
        signOutButton.layer.cornerRadius = 15
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let updateModalViewControler = segue.destination as? UpdateModalViewController{
            updateModalViewControler.bind(userServiceType: userServiceType!)
        }
        
        if let alertModalViewController = segue.destination as? AlertViewController{
            alertModalViewController.bind(alertType: alertType, content: message)
        }
    }
 
   
    
    @IBAction func passwordButtonOnTapped(_ sender: Any) {
        performSequeToUpdateWith(userServiceType: .UPDATE_PASSWORD)
    }
    
    @IBAction func emailButtonOnTapped(_ sender: Any) {
        performSequeToUpdateWith(userServiceType: .UPDATE_EMAIL)
    }
    
    @IBAction func displayNameButtonOnTapped(_ sender: Any) {
       performSequeToUpdateWith(userServiceType: .UPDATE_NAME)
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
         networkFacade.signOut()
         handleControllerTransitionWith(identifier: Identifiers.SIGN_IN_CONTROLLER)
    }
    
    private func performSequeToUpdateWith(userServiceType: UserServiceType){
        self.userServiceType = userServiceType
        performSegue(withIdentifier: Identifiers.PROFILE_TO_UPDATEMODAL, sender: nil)
    }
}

//Create extension to conform Delegate
extension ProfileViewController: NetworkFacadeDelegate{
    func didReceiveUser1(user: User) {
        self.currrentUser = user
    }
    
    func didUpload1(isUpdated: Bool, message: String){
        self.isUpdated = isUpdated
        self.message = message
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
            networkFacade.uploadImage(folderName: "users/\(currrentUser.uid!)", imageFile: selectedImage, fileName: "avatar")
        }
        
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        if let profileView = view.viewWithTag(ViewTags.PROFILE_VIEW){
            profileView.stopIndicatorAnnimation()
        }
    }
}

