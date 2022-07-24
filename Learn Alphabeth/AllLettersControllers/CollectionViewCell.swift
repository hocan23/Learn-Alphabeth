//
//  CollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by Rashit on 03/07/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var animalImage: UIImageView!
    
    
    
    
     override func awakeFromNib() {
         super.awakeFromNib()
//         animalImage.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: 5, paddingBottom: 5, paddingLeft: 5, paddingRight: 5, width: 0, height: 0)
         contentView.layer.cornerRadius = 20
     }

}
