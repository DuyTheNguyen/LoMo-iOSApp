//
//  CommentViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 15/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class CommentModalViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentModal: UIView!
    
    @IBOutlet weak var commentModalImageView: UIImageView!
    private let userAuthentiationNetworkController = UserNetworkController()
    private let databaseNetworkController = DatabaseNetworkController()
    
    private var currentUser: User!
    var selectedMovie: Movie!
    private var isCommentAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentModal.roundedCorner(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 20)
        
        userAuthentiationNetworkController.delegate = self
        userAuthentiationNetworkController.authenticationListener()
        
        databaseNetworkController.delegate = self
        
        commentTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commentModalImageView.image = Icons.EDIT_ADD
        commentTextView.text = ""
        commentTextView.becomeFirstResponder()
       
    }
    
    @IBAction func cancelButtonOnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //add comment to the database
    @IBAction func confirmButtonOnTapped(_ sender: Any) {
        guard commentTextView.text != "" else{
            print("Empty content")
            return
        }
        
        guard let movie = selectedMovie else{
            fatalError("CommentViewController: no movie")
        }
        
        let comment = Comment( commentId: "",
                               userId: (currentUser?.uid)!,
                               userName: currentUser?.displayName ?? (currentUser?.email)!,
                               image: currentUser?.photoURL ?? "",
                               content: commentTextView.text,
                               timestamp: Date().getCurrentDateInString())
        
        databaseNetworkController.addComment(movieId: movie.id!, comment: comment)
        
        if isCommentAdded {
             dismiss(animated: true, completion: nil)
        }else{
            print("CommentViewController: Could not add comment")
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


//Create extension to conform Delegate
extension CommentModalViewController: UserNetworkControllerDelegate{
    func didReceiveUser(user: User) {
        self.currentUser = user
    }
}

extension CommentModalViewController: DatabaseNetworkControllerDelegate{
    func isCommentAdded(isIt: Bool){
        self.isCommentAdded = isIt
    }
}

extension CommentModalViewController: UITextViewDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentTextView.resignFirstResponder()
    }
}
