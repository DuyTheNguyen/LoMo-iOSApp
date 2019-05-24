//
//  CommentListCollectionViewCell.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 16/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class CommentListCollectionViewCell: UICollectionViewCell {
    var comment: Comment!
    
    @IBOutlet weak var commentContentLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    @IBOutlet weak var commentImageView: CustomUIImageView!
    @IBOutlet weak var commentNameLabel: UILabel!
    
    
    
    func bind(comment: Comment){
        commentDateLabel.text = comment.timestamp.fromTimeStampToCustomDate()
        commentContentLabel.text = comment.content
        commentNameLabel.text = comment.userName
        
        commentImageView.image = Icons.USER_MALE
        if comment.image != ""{
            commentImageView.load(urlString: comment.image, cacheImage: false)
            commentImageView.setRounded()
        }
        
    }
}
