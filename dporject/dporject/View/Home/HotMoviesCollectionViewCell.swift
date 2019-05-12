//
//  HotMoviesCollectionViewCell.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 9/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class HotMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    func displayContent(imageString: String, movieName: String){
        movieNameLabel.text = movieName
        
        imageView.load(imageString: imageString)
    }
}
