//
//  CollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by Rashit on 03/07/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var letterImage: UIImageView!
    
    
    
     override func awakeFromNib() {
         super.awakeFromNib()
         contentView.layer.cornerRadius = 20
     }

}
