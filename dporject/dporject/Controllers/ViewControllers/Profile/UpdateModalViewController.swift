//
//  UpdateModalViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 16/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class UpdateModalViewController: UIViewController {
    
    private let networkFacade = NetworkServiceFacade()
    

    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var canelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var updateModalUIImageView: UIImageView!
    
    private var userServiceType: UserServiceType!
    private var isUpdated: Bool!
    private var alertType: AlertType!
    private var message = String(){
        didSet{
            self.view.stopIndicatorAnnimation()
            if isUpdated{
                alertType = AlertType.SUCCESS
                performSegue(withIdentifier: Identifiers.UPDATEMODAL_TO_ALERTMODAL, sender: nil)
            }
            else{
                alertType = AlertType.FALIED
                performSegue(withIdentifier: Identifiers.UPDATEMODAL_TO_ALERTMODAL, sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextField.delegate = self
        networkFacade.delegate = self
        
        //Using notification for success case
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissModal), name: NSNotification.Name(rawValue: Notifications.CLOSE_UPDATE_MODAL), object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = "Update \(userServiceType.rawValue)"
        updateModalUIImageView.setUpImageViewWithIcons(userServiceType: userServiceType)
        contentTextField.text = ""
        contentTextField.becomeFirstResponder()
        
    }
    
    @objc func dismissModal(){
        dismiss(animated: true, completion: nil)
    }
    
   
    
    public func bind(userServiceType: UserServiceType){
       self.userServiceType = userServiceType
    }
    
    @IBAction func saveButtonOnTapped(_ sender: Any) {
        guard let newValue = contentTextField.text else{
            print("contentTextField is nil")
            return
        }
        
       
        
        guard newValue != "" else{
            isUpdated = false
            message = AlertMessages.FAILED_EMPTY_STRING
            return
        }
        
        switch  userServiceType! {
        case .UPDATE_EMAIL:
            guard newValue.isValidEmail() else {
                isUpdated = false
                message = AlertMessages.FAILED_INVALID_EMAIL
                return
            }
            networkFacade.updateEmail(email: newValue)
        case .UPDATE_NAME:
            networkFacade.updateName(name: newValue)
        case .UPDATE_PASSWORD:
            networkFacade.updatePassword(email: newValue)
        default:
            print("")
        }
        
       
        self.view.startIndicatorAnnimation()
    }
    
    @IBAction func cancelButtonOnTapped(_ sender: Any) {
       dismissModal()
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

//Create extension to conform Delegate
extension UpdateModalViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentTextField.resignFirstResponder()
    }
}

extension UpdateModalViewController:NetworkServiceFacadeDelegate{
    func updateData1(isUpdated: Bool, message: String) {
        self.isUpdated = isUpdated
        self.message = message
    }
}
