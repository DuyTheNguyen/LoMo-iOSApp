//
//  CommentViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 15/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentModal: UIView!
    
    private let userAuthentiationNetworkController = UserAuthenticationNetworkController()
    
    private var currentUser: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentModal.roundedCorner(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 20)
        
        userAuthentiationNetworkController.delegate = self
        userAuthentiationNetworkController.authenticationListener()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commentTextView.text = "Please place your comment here!"
    }
    
    @IBAction func cancelButtonOnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonOnTapped(_ sender: Any) {
        guard commentTextView.text != "" else{
            print("Empty content")
            return
        }
        
        let comment = Comment( userId: (currentUser?.uid)!,
                               userName: currentUser?.displayName ?? (currentUser?.email)!,
                               image: currentUser?.photoURL ?? "",
                               content: commentTextView.text,
                               timestamp: Date().getCurrentDateInString())
        print(comment)
        
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
extension CommentViewController: UserAuthenticationNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        self.currentUser = user
    }
    
    
}
