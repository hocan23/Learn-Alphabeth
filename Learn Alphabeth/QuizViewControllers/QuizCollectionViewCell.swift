//
//  QuizCollectionViewCell.swift
//  Learn Alphabeth
//
//  Created by fdnsoft on 14.07.2022.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var autoSwitch: UISwitch!
    @IBOutlet weak var animalImg: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    var contentWight = UIScreen.main.bounds.size.width
    var contentHeight = UIScreen.main.bounds.size.height*0.6
    override func awakeFromNib() {
        super.awakeFromNib()
        print(UIScreen.main.bounds.size.height)
        print(contentView.frame.height)
       
        animalImg.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: contentWight*0.5, height: contentHeight*0.35)
      
           
        playButton.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: contentWight*0.1, height: contentWight*0.1)
        playImage.anchor(top: cardView.topAnchor, bottom: nil, leading: cardView.leadingAnchor, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: contentWight*0.1, height: contentWight*0.1)
        
        autoSwitch.anchor(top: contentView.topAnchor, bottom: nil, leading: nil, trailing: contentView.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeft: 0, paddingRight: -30, width: 45, height: 40)
        progressBar.anchor(top: nil, bottom: cardView.bottomAnchor, leading: cardView.leadingAnchor, trailing: progressLabel.leadingAnchor, paddingTop: 0, paddingBottom: -30, paddingLeft: 10, paddingRight: -10, width:contentWight*0.6, height: 15)
        progressLabel.anchor(top: nil, bottom: cardView.bottomAnchor, leading: progressBar.trailingAnchor, trailing: cardView.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingLeft: 0, paddingRight: -10, width:0, height: 15)
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardView.layer.shadowRadius = 3
        cardView.layer.shadowOpacity = 0.7
        cardView.backgroundColor = UIColor.white
        progressLabel.textColor = UIColor(red: 53/255, green: 85/255, blue: 133/255, alpha: 1)
        
    }
}
