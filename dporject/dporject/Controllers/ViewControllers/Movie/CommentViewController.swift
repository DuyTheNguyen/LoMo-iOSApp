//
//  CommentViewController.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 15/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentModal: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        commentModal.roundedCorner(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 20)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeCommentModalOnTapped(_ sender: Any) {
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
