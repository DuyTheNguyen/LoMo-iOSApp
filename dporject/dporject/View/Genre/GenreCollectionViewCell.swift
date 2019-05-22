//
//  GenreCollectionViewCell.swift
//  dporject
//
//  Created by THE DUY NGUYEN on 12/5/19.
//  Copyright © 2019 THE DUY NGUYEN. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreImageView: UIImageView!
    
   
    
    
    func bind(genre: Genre){
        self.loadCustomisedCell(widthCornerRadius: 15)
        
        nameLabel.text = genre.name
        nameLabel.layer.opacity = 1
        
        genreImageView.load(urlString: genre.image ?? "")
        genreImageView.layer.opacity = 0.6
       
       
    }
}
