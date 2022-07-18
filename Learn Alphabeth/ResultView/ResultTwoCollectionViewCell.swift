//
//  ResultTwoCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 17.07.2022.
//

import UIKit

class ResultTwoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelTwo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor(red: 0.762, green: 0.893, blue: 1, alpha: 0.51).cgColor
        contentView.layer.shadowOffset = CGSize(width: -3, height: 4)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 1
        
    }
}
