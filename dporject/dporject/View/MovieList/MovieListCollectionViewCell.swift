//
//  MovieListCollectionViewCell.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    func bind(movie: Movie){
        movieNameLabel.text = movie.name
        movieImage.load(imageString: movie.image!)
        movieImage.roundedCorner(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 20)
    }
}
