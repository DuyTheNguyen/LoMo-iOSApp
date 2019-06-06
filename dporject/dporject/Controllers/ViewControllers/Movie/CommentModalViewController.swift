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
    private let networkFacade = NetworkFacade()
    
    private var currentUser: User!
    var selectedMovie: Movie!
    private var isCommentAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentModal.roundedCorner(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 20)
        
        commentTextView.delegate = self
        // Do any additional setup after loading the view.
        
        networkFacade.delegate = self
        networkFacade.checkCurrentUserStatus()
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
        guard let vaildComment = commentTextView.text else {
            print("Comment text view is nil")
            return
        }
        
        guard vaildComment != "" else{
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
                               timestamp: String(Date().timeIntervalSince1970))
        
        //databaseNetworkController.addComment(movieId: movie.id!, comment: comment)
        networkFacade.addComment(movieId: movie.id!, object: comment)
        
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
extension CommentModalViewController: UITextViewDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentTextView.resignFirstResponder()
    }
}

extension CommentModalViewController: NetworkFacadeDelegate{
    func isAdded(isIt: Bool){
        self.isCommentAdded = isIt
    }
    func didReceiveUser1(user: User) {
        self.currentUser = user
    }
}


