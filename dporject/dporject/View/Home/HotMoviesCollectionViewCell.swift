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
    
    func bind(movie: Movie){
        movieNameLabel.text = movie.name
        
        imageView.load(imageString: movie.image!)
        imageView.roundedCorner(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
        
    }
}
