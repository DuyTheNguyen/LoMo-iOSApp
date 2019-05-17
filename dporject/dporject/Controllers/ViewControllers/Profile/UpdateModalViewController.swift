//
//  UpdateModalViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 16/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class UpdateModalViewController: UIViewController {
    
    private let userNetworkController = UserNetworkController()
    

    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var canelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var updateModalUIImageView: UIImageView!
    
    private var titleValue: String!
    private var isUpdated: Bool!
    private var message = String(){
        didSet{
            self.view.stopIndicatorAnnimation()
            if isUpdated{
                dismiss(animated: true, completion: nil)
            }
            else{
                print(message)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextField.delegate = self
        userNetworkController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = "Update \((titleValue)!)"
        updateModalUIImageView.image = Icons.EDIT_ADD
        contentTextField.text = ""
        contentTextField.becomeFirstResponder()
        
    }
    
    public func bind(type: String){
       titleValue = type
    }
    
    @IBAction func saveButtonOnTapped(_ sender: Any) {
        guard let newValue = contentTextField.text else{
            print("Content is nil or empty")
            return
        }
        userNetworkController.updateProfile(titleValue, withValue: newValue)
        self.view.startIndicatorAnnimation(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
    }
    
    @IBAction func cancelButtonOnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

//Create extension to conform Delegate
extension UpdateModalViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentTextField.resignFirstResponder()
    }
}

extension UpdateModalViewController:UserNetworkControllerDelegate{
    func updateProfile(isUpdated: Bool, message: String) {
        self.isUpdated = isUpdated
        self.message = message
    }
}
