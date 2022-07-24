//
//  PracticeCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 16.07.2022.
//

import UIKit

class PracticeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewCard: UIView!
    
    
    @IBOutlet weak var practiceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 20

    }
}
