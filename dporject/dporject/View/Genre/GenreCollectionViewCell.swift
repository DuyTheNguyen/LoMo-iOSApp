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
    
    func bind(name: String){
        nameLabel.text = name
    }
}
